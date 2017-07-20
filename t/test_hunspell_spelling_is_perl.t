use 5.020;
use Test2::V0;
use Test::Spelling::Hunspell;

ok('Test::Spelling::Hunspell'->can('_is_perl'), '_is_perl exists');

*is_perl = \&Test::Spelling::Hunspell::_is_perl;

is(is_perl("foo.sh"), F(), "sh script is not perl");

foreach my $ext (qw( pl plx pm pod t ))
{
  is(is_perl("foo.$ext"), T(), "foo.$ext is perl");
}

is(is_perl("corpus/binisperl"),  T(), "corpus/binisperl is perl");
is(is_perl("corpus/binnotperl"), F(), "corpus/binnotperl is perl");

done_testing;
