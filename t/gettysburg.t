use strict;
use warnings;
use 5.020;
use Test::Stream -V1, SkipWithout => ['Alien::Hunspell::EN::US'];
use Test::Spelling::Hunspell;
use Alien::Hunspell::EN::US;

plan 1;

my $class = 'Alien::Hunspell::EN::US';
set_language_files( $class->aff_file, $class->dic_file );
pod_file_spelling_ok "corpus/gettysburg.pod";
