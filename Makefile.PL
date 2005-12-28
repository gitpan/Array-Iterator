use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'		=> 'Array::Iterator',
    'VERSION_FROM'	=> 'lib/Array/Iterator.pm', # finds $VERSION
    'PREREQ_PM'		=> {
		'Test::More'      => .47,
		'Test::Exception' => .15
		}
);
