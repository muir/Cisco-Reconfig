
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile being created.
WriteMakefile(
	'NAME' => 'Cisco::Reconfig',
	'DISTNAME' => 'Cisco-Reconfig',
	'VERSION_FROM' => 'Reconfig.pm',
	($] >= 5.005 ?
	    ('ABSTRACT' => 'Parse Cisco-style configuration files',
	     'AUTHOR'	=> 'David Muir Sharnoff <muir@idiom.org>') : ()),
	'dist'   => {COMPRESS=>'gzip', SUFFIX=>'gz'},
	'PREREQ_PM' => {
		 'Scalar::Util' => 1.07,
	},
);

package MY;

sub postamble {
    <<"END_OF_POSTAMBLE";

pm_to_blib: README

README: Reconfig.pod
\tpod2text Reconfig.pod >README

END_OF_POSTAMBLE
}
