#!/user/bin/perl

use strict;
use warnings;

my $numFakeDomains = 100;
my $numInserts = 1001; #50;

my @domainsList;

# genereate an array of domains
for (my $i=0; $i<$numFakeDomains; $i++) {
	my $fakeDomain = "@".$i.".com";
	push(@domainsList, $fakeDomain);
}

# generate email addresses by picking random domains
for (my $i=0; $i<$numInserts; $i++) {
	my $randDomain = int(rand($numFakeDomains));
	
	my $fakeEmail = $i."".$domainsList[$randDomain];

	if ($i == $numInserts - 1) {
		# use the last insert to print the statistics
		system("/usr/bin/perl ./domain_stats.pl --addr=$fakeEmail --stats=1 --dbg=1");
	} else {
		system("/usr/bin/perl ./domain_stats.pl --addr=$fakeEmail --dbg=1");
	}
}



