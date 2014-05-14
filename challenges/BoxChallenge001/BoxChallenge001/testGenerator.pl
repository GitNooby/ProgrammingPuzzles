#!/usr/local/bin/perl
open (MYFILE, '>test.txt');
#$numcmds = 1000000-1;
$numcmds =  500000;
$cacheSize = 10;

print MYFILE $numcmds."\n";
print MYFILE "BOUND ".$cacheSize."\n";
$numcmds = $numcmds - 1;

$SET_0 = 1;
$SET_1 = 40;

$GET_0 = 41;
$GET_1 = 70;

$PEEK_0 = 71;
$PEEK_1 = 90;
$DUMP_0 = 91;
$DUMP_1 = 100;

for ($iter=0; $iter<$numcmds; ) {
	$low = 1;
	$high = 100;
	$rand = int(rand($high-$low-1)) + $low;
	if ($SET_0 <= $rand && $rand <= $SET_1) {
		$cmdlenrand = int(rand($cacheSize-4-1)) + 4;
		for ($j=0; $j<$cmdlenrand; $j++) {
			$iter++;
			print MYFILE "SET ".$iter." ".$iter."\n";
		}
	}
	elsif ($GET_0 <= $rand && $rand <= $GET_1) {
		$cmdlenrand = int(rand($cacheSize-4-1)) + 4;
		for ($j=0; $j<$cmdlenrand; $j++) {
			$iter++;
			$rand2 = int(rand($iter-1));
			print MYFILE "GET ".$rand2."\n";
		}
	}
	elsif ($PEEK_0 <= $rand && $rand <= $PEEK_1) {
		$cmdlenrand = int(rand($cacheSize-4-1)) + 4;
		for ($j=0; $j<$cmdlenrand; $j++) {
			$iter++;
			$rand2 = int(rand($iter-1));
			print MYFILE "PEEK ".$rand2."\n";
		}
	}
	elsif ($DUMP_0 <= $rand && $rand <= $DUMP_1) {
		$iter++;
		print MYFILE "DUMP\n";
	} else {
		print $rand." ERROR\n";
	}
}

close (MYFILE)
