#!/usr/local/bin/perl
open (MYFILE, '>test.txt');
$numcmds =  1000000;
$cacheSize = 1000;
$minCacheSize = 0;
$extraCmds = 200;

print MYFILE $numcmds."\n";
print MYFILE "BOUND ".$cacheSize."\n";
$numcmds = $numcmds - 1;


$BOUND_0 = 1;
$BOUND_1 = 10;
$SET_0 = 11;
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
	if ($BOUND_0 <= $rand && $rand <= $BOUND_1) {
		$newCacheSize = int(rand($cacheSize-$minCacheSize-1)) + $minCacheSize;
		$iter++;
		print MYFILE "BOUND ".$newCacheSize."\n";
	}
	elsif ($SET_0 <= $rand && $rand <= $SET_1) {
		$cmdlenrand = int(rand($cacheSize+$extraCmds));
		for ($j=0; $j<$cmdlenrand; $j++) {
			$iter++;
			print MYFILE "SET ".$iter." ".$iter."\n";
		}
	}
	elsif ($GET_0 <= $rand && $rand <= $GET_1) {
		$cmdlenrand = int(rand($cacheSize+$extraCmds));
		for ($j=0; $j<$cmdlenrand; $j++) {
			$iter++;
			$rand2 = int(rand($iter-1));
			print MYFILE "GET ".$rand2."\n";
		}
	}
	elsif ($PEEK_0 <= $rand && $rand <= $PEEK_1) {
		$cmdlenrand = int(rand($cacheSize+$extraCmds));
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
