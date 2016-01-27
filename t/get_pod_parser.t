use strict;
use warnings;
use 5.020;
use Test::Stream -V1;
use Test::Spelling::Hunspell;

plan 1;

my $parser = eval { Test::Spelling::Hunspell::_get_pod_parser() };
diag $@ if $@;

is ref($parser), 'Pod::Spell', 'got the right pod parser';

