#!/usr/bin/perl -I. -w

#
# The configuration file in this test is buggy.  It's a Cisco
# bug so we'll try to work around it.
#

use Cisco::Reconfig;
use Test;
use Carp qw(verbose);
use Scalar::Util qw(weaken);

my $debugdump = 0;

BEGIN { plan test => 2 };

sub wok
{
	my ($a, $b) = @_;
	require File::Slurp;
	import File::Slurp;
	write_file('x', $a);
	write_file('y', $b);
	return ok($a,$b);
}

my $config = readconfig(\*DATA);

if ($debugdump) {
	require Data::XDumper;
	require File::Slurp;
	File::Slurp::write_file("dumped", join("\n",Data::XDumper::Dump($config)));
	exit(0);
}

ok(defined $config);

# -----------------------------------------------------------------

$x = $config->get('crypto ca certificate chain _SmartCallHome_ServerCA');
ok($x->alltext,<<END);
crypto ca certificate chain _SmartCallHome_ServerCA
 certificate ca 6ecc7aa5a7032009b8cebcf4e952d491
    308205ec 308204d4 a0030201 0202106e cc7aa5a7 032009b8 cebcf4e9 52d49130
    6119b5dd cdb50b26 058ec36e c4c875b8 46cfe218 065ea9ae a8819a47 16de0c28
    6c2527b9 deb78458 c61f381e a4c4cb66
  quit
END

# -----------------------------------------------------------------

__DATA__
crypto ca certificate map klant_dopheideb_certmap 10
 subject-name attr ea eq bart.dopheide@axians.com
crypto ca certificate chain _SmartCallHome_ServerCA
 certificate ca 6ecc7aa5a7032009b8cebcf4e952d491
    308205ec 308204d4 a0030201 0202106e cc7aa5a7 032009b8 cebcf4e9 52d49130
    6119b5dd cdb50b26 058ec36e c4c875b8 46cfe218 065ea9ae a8819a47 16de0c28
    6c2527b9 deb78458 c61f381e a4c4cb66
  quit
crypto ca certificate chain beheervpn
 certificate 9c890453
    30820308 308201f0 a0030201 0202049c 89045330 0d06092a 864886f7 0d010105
