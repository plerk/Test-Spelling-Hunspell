use strict;
use warnings;
use 5.020;
use Test::Stream qw( -V1 -Tester );
use Test::Spelling::Hunspell;

plan 9;

ok('Test::Spelling::Hunspell'->can('_is_perl'), '_is_perl exists');

*is_perl = \&Test::Spelling::Hunspell::_is_perl;

is(is_perl("foo.sh"), F(), "sh script is not perl");

foreach my $ext (qw( pl plx pm pod t ))
{
  is(is_perl("foo.$ext"), T(), "foo.$ext is perl");
}

is(is_perl("corpus/binisperl"),  T(), "corpus/binisperl is perl");
is(is_perl("corpus/binnotperl"), F(), "corpus/binnotperl is perl");
