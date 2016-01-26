use strict;
use warnings;
use Test::Stream -V1;
use Test::Spelling::Hunspell;

skip_all 'test requires english dictionary'
  unless -r "/usr/share/hunspell/en_US.aff"
  &&     -r "/usr/share/hunspell/en_US.dic";

plan 1;

set_language_files "/usr/share/hunspell/en_US.aff", "/usr/share/hunspell/en_US.dic";
pod_file_spelling_ok "corpus/gettysburg.pod";
