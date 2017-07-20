use 5.020;
use Test2::V0;
use Test::Spelling::Hunspell;

my $parser = eval { Test::Spelling::Hunspell::_get_pod_parser() };
diag $@ if $@;

is ref($parser), 'Pod::Spell', 'got the right pod parser';

done_testing;
