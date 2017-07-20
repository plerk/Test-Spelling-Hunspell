use 5.020;
use Test2::V0;
use Test::Spelling::Hunspell;

set_language_files 'corpus/test.aff', 'corpus/test.dic';

my $spell = eval { Test::Spelling::Hunspell::_get_hunspell() };
diag $@ if $@;

like ref($spell), qr{^Text::Hunspell(|::FFI)$}, 'got a speller';

done_testing;
