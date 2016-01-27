use strict;
use warnings;
use 5.020;
use experimental qw( signatures );
use Test::Spelling::Hunspell;

foreach my $file (@ARGV)
{
  my $parser = Test::Spelling::Hunspell::Parser->new;
  $parser->parse_file($file);
  require YAML;
  print YAML::Dump({
    $file => $parser->words
  });
}
