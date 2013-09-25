#!/usr/bin/perl

BEGIN {
	eval { require File::Slurp; };
	if ($@) {
		print "1..0 # Skip File::Slurp not installed\n";
		exit 0;
	}
}

use Cisco::Reconfig;
use Test::More;
use Carp qw(verbose);
use FindBin;
use File::Slurp;

my $debugdump = 0;

my $dd = "$FindBin::Bin/datadir";

@files = sort grep { /\w/ } read_dir("$dd");

import Test::More tests => scalar(@files);

for my $file (@files) {
	if ($file =~ /\.ignorebadindent$/) {
		$Cisco::Reconfig::bad_indent_policy = 'IGNORE';
	} else {
		$Cisco::Reconfig::bad_indent_policy = 'DIE';
	}
	my $config;
	eval {
		$config = readconfig("$dd/$file");
	};
	ok(defined $config, $file);
	diag "FAILED TO PARSE $file!\n$@" if $@;
}

