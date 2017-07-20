use 5.020;
use Test2::Require::Module 'Alien::Hunspell::EN::US';
use Test2::V0;
use Test::Spelling::Hunspell;
use Alien::Hunspell::EN::US;

my $class = 'Alien::Hunspell::EN::US';
set_language_files( $class->aff_file, $class->dic_file );
pod_file_spelling_ok "corpus/gettysburg.pod";

done_testing;
