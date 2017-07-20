use 5.020;
use Test2::V0;
use Test::Spelling::Hunspell;
use File::Basename qw( basename );

ok('Test::Spelling::Hunspell'->can('_all_pod_files'), "can _all_pod_files");

*all_pod_files = \&Test::Spelling::Hunspell::_all_pod_files;

my @files = all_pod_files('corpus/dist1/');

# binisperl
# Bar.pm
# foo.t


is(
  [map { basename $_ } @files],
  [qw( binisperl Bar.pm foo.t )],
  'looks good'
);

done_testing;
