#!/usr/local/bin/perl -w
use strict;
use warnings;
use Getopt::Long;

my $rootdir = "";
my $verbose;
my @queue;
my @outputArray;

GetOptions ("rootdir=s" => \$rootdir,
"v" => \$verbose) or die("error in cmdline args\n");

sub help {
    print "DESCRIPTION:\n";
    print "this script takes in a root directory and outputs the children using BFS\n";
    print "USAGE:\n";
    print "-rootdir: manditory input";
    print "-v: if u want to be verbose";
    print "perl $0 -rootdir <root directory> [-v]\n";
}

sub main {
    my $newDir;
    
    if ($rootdir eq "") {
        &help;
    }
    if (!(-e $rootdir && -d $rootdir)) {
        print "$rootdir not found or is not a directory\n";
        return;
    }
    
    push(@queue, $rootdir);
    while (@queue > 0) { #while queue is not empty
        my $node = shift(@queue);

        if (-d $node) {
            opendir(DIR, $node);
            while (my $subnode = readdir(DIR)) {

                if ($subnode =~ m/^\./) {
                    next;
                } else {
                    $newDir = "$node/$subnode";
                    push(@queue, $newDir);
                }
            }
            print "dir  $node\n" if $verbose;
            closedir(DIR);
        } else {
            print "file $node\n" if $verbose;
        }
        push (@outputArray, $node);
    }
    print "done BFS traversal\n";
#    foreach my $item (@outputArray) {
#        print "$item\n";
#    }
}

&main;
