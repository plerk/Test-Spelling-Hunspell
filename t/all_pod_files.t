use strict;
use warnings;
use Test::Stream qw( -V1 -Tester );
use Test::Spelling::Hunspell;
use File::Basename qw( basename );

plan 2;

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
