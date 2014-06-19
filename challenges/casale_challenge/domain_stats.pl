#!/usr/bin/perl

use strict;
use warnings;

use FindBin qw($Bin);
use lib "$Bin";
use DB;

use Getopt::Long;
use DateTime;
use Email::Valid;
use Email::Address;
use DateTime;

# check if user provided valid input, output help message
my $inputAddress = "";
my $shouldComputeStats = 0;
my $debugMode = 0;
my $input_file = "./input_file.txt";
my $output_file = "./output_file.txt";
GetOptions("addr=s"  => \$inputAddress,
           "stats=s" => \$shouldComputeStats,
           "dbg=s"   => \$debugMode);
if ($inputAddress eq "") {
	print "Script usage:\n";
	print "perl $0 --addr=<email_addr> [--stats=<bool>] [--dbg=<bool>]\n\n";
	print "Description: This script will take an email address as input via the \"--addr\" flag and insert the email address into the \"test\" database\n";
	print "             The optional flag \"--stats\" will output to console the top 50 domains with the highest growth rates in the last 30 days\n";
	print "             The optional flag \"--dbg\" is meant for debugging by randomizing the date it's inserted into \"test\" database within the last 5 days\n";
	exit;
}

# isValidEmail - determines if a valid email address is provided
#        isValidEmail( $string ), return <boolean type>
sub isValidEmail {
	my $string = shift;
	if (Email::Valid->address($string)) {
		return 1;
	}
	return 0;
}

# getEmailDomain - parses the input for the email domain
#        getEmailDomain( $string ), return <string type>
sub getEmailDomain {
	my $string = shift;
	my ($addr) = Email::Address->parse($string);
	my $user = $addr->user;
	my $domain = $addr->host;
	return $domain;
}

# trackDomain - updates the "domains" table's "total" column by inserting or updating the input domain to the table
#        trackDomain( $dbh, $domain ), return <the number of times this domain is stored>
sub trackDomain {
	my $dbh = shift;
	my $domain = shift;

	my $sqlquery = "SELECT total FROM domains WHERE domain = '$domain'";
	my @result = GUI::DB::query($dbh, $sqlquery);
	my $totalCount = 1;

	if (@result == 0) {
		$sqlquery = "INSERT INTO domains VALUES ('$domain', 1)";
		GUI::DB::query($dbh, $sqlquery);
	} else {
		$totalCount = $result[0]->{total};
		$totalCount = $totalCount + 1;
		$sqlquery = "UPDATE domains SET total=$totalCount WHERE domain='$domain'";
		GUI::DB::query($dbh, $sqlquery);
	}
	return $totalCount;
}

# insertIntodomainStats - insert into "domain_stats" table the date that the corresponding domain is stored, also updates the count
#         insertIntoDomainStats( $dbh, $domain, $currentDate), return <the number of times this domain is stored for this date>
sub insertIntoDomainStats {
	my $dbh = shift;
	my $domain = shift;
	my $currentDate = shift;
	my $count = 1;
	
	my $sqlquery = "SELECT count FROM domain_stats WHERE thedate='$currentDate' AND domain='$domain'";
	my @result = GUI::DB::query($dbh, $sqlquery);
	if (@result == 0) {
		$sqlquery = "INSERT INTO domain_stats VALUES ('$currentDate', '$domain', 1)";
		GUI::DB::query($dbh, $sqlquery);
	} else {
		$count = $result[0]->{count};
		$count = $count + 1;
		$sqlquery = "UPDATE domain_stats SET count=$count WHERE thedate='$currentDate' AND domain='$domain'";
		GUI::DB::query($dbh, $sqlquery);
	}
	return $count;
}

# insertIntoMailing - inserts an email address to "mailing" table if it wasn't already inserted
#         insertInToMailing( $dbh, $emailAddress), return void
sub insertIntoMailing {
	my $dbh = shift;
	my $emailAddress = shift;

	my $sqlquery = "SELECT addr FROM mailing WHERE addr='$emailAddress'";
	my @result = GUI::DB::query($dbh, $sqlquery);
	if (@result == 0) {
		$sqlquery = "INSERT INTO mailing VALUES ('$emailAddress')";
		GUI::DB::query($dbh, $sqlquery);
	}
}

# report30DayStats - reports the top 50 domains with the highest growth rate in the last 30 days
#          report30DayStats( $dbh, $currentDate ), return void
sub report30DayStats {
	my $dbh = shift;
	my $currentDate = shift;
	
	my $days = 30;

	my %domainsCount;

	# get the number of times each domain was added in the past 30 days
	for (my $i=0; $i<$days; ++$i) {
		my $pastDate = $currentDate->clone;
		$pastDate->subtract(days => $i);

		my $sqlquery = "SELECT domain, count FROM domain_stats WHERE thedate='$pastDate'";
		my @result = GUI::DB::query($dbh, $sqlquery);

		if (@result != 0) {
			for (my $j=0; $j<@result; $j++) {
				my $domain = $result[$j]->{domain};
				my $pastCount = $result[$j]->{count};
				if (exists($domainsCount{$domain}) == 0) {
					$domainsCount{$domain} = $pastCount;
				} else {
					$domainsCount{$domain} = $domainsCount{$domain} + $pastCount;
				}
			}
		}
	}

	# compute the percentage growth of each domain
	while ((my $aDomain, my $theCount) = each(%domainsCount)) {
		my $sqlquery = "SELECT total FROM domains WHERE domain='$aDomain'";
		my @result = GUI::DB::query($dbh, $sqlquery);
		my $total = $result[0]->{total};
		my $percentageGrowth = $theCount / $total;
		$domainsCount{$aDomain} = $percentageGrowth;
#		print "domain:".$aDomain." count:".$theCount." total:".$total." percentage:".$domainsCount{$aDomain}." ".$percentageGrowth."\n";
	}

	open OUTFILE, ">>".$output_file;

	print "The top 50 domains by percentage growth in the last $days days are:\n";
	print OUTFILE "The top 50 domains by percentage growth in the last $days days are:\n";

	my $iter = 0;
	foreach my $domain (sort { $domainsCount{$b} <=> $domainsCount{$a} } keys %domainsCount) {
		my $percentage = $domainsCount{$domain} * 100;
		
		print $iter.": DOMAIN: ".$domain."   GROWTH:".$percentage."%\n";
		print OUTFILE $iter.": DOMAIN: ".$domain."   GROWTH:".$percentage."%\n";
		
		$iter++;
		if ($iter >= 50) {
			last;
		}
	}

	print "done\n";
	print OUTFILE  "done\n";
	close OUTFILE;
}

# main - the main entry function of this entire script
sub main {
	my $timeNow = DateTime->today;
	if ($debugMode != 0) {
		# if we're in debug mode, then randomly insert a past date
		my $randInt = int(rand(41)); #generate a number between 0 and 40, we only insert in the past 40 days in debug mode
		$timeNow->subtract(days => $randInt);
	}
	
	print "You entered $inputAddress\n";

	# 1. determine if we're working with a valid email address format
	my $isValidAddr = &isValidEmail($inputAddress);
	if ($isValidAddr == 0) {
		print "You entered an invalid email address\n";
		exit;
	}

	open INFILE, '>>'.$input_file;
	print INFILE $timeNow." ".$inputAddress."\n";
	close INFILE; 

	# 2. extract the domain from the email
	my $inputDomain = &getEmailDomain($inputAddress);

	# 3. get the db handler
	my $dbh = GUI::DB::dbConnect();

	# 4. determine if we have recorded the domain in "domains" table,
	#    record the domain if we didn't, return its current total
	my $domainTotal =  &trackDomain($dbh, $inputDomain);

	# 5. determine if we have already recorded the domain for today,
	#    record the domain, return its total for today
	my $todayTotalForDomain = &insertIntoDomainStats($dbh, $inputDomain, $timeNow);

	# 6. determine if we have already recorded the email address.
	#    record the email address
	&insertIntoMailing($dbh, $inputAddress);
	
	# 7. compute the statistics
	$timeNow = DateTime->today;
	if ($shouldComputeStats != 0) {
		&report30DayStats($dbh, $timeNow);
	}

	$dbh->disconnect();
}

# call main to get things started
main();




