use strict;
use warnings;
use Test::Stream -V1;
use Test::Spelling::Hunspell;

plan 1;

set_language_files 'corpus/test.aff', 'corpus/test.dic';

my $spell = eval { Test::Spelling::Hunspell::_get_hunspell() };
diag $@ if $@;

like ref($spell), qr{^Text::Hunspell(|::FFI)$}, 'got a speller';

