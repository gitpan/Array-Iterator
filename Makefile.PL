use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Array::Iterator',
    'VERSION_FROM'	=> 'Iterator.pm', # finds $VERSION
    'PREREQ_PM'		=> {
		'Test::More'      => .47,
		'Test::Exception' => .15
            }
);
