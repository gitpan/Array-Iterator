
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  'build_requires' => {
    'Module::Build' => '0.3601'
  },
  'configure_requires' => {
    'Module::Build' => '0.3601'
  },
  'dist_abstract' => 'A simple class for iterating over Perl arrays',
  'dist_author' => [
    'Steven Haryanto <stevenharyanto@gmail.com>'
  ],
  'dist_name' => 'Array-Iterator',
  'dist_version' => '0.07',
  'license' => 'perl',
  'module_name' => 'Array::Iterator',
  'recommends' => {},
  'recursive_test_files' => 1,
  'requires' => {
    'Test::Exception' => '0'
  },
  'script_files' => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
