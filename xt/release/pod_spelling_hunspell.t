use strict;
use warnings;

BEGIN {
  unless(eval { require Test::Stream; 1 })
  {
    require Test::More;
    Test::More::plan(skip_all => 'test requires Test::Stream');
  }
}

use Test::Stream -V1, SkipWithout => [
                        'Test::Spelling::Hunspell',
                        'YAML',
                        'Dist::Zilla::PluginBundle::Author::Plicease',
                      ];
use Test::Spelling::Hunspell;
use FindBin;
use File::Spec;
use YAML qw( LoadFile );

my $config_filename = File::Spec->catfile(
  $FindBin::Bin, 'release.yml',
);

my $config = LoadFile($config_filename)
  if -r $config_filename;

skip_all 'disabled' if $config->{pod_spelling_hunspell}->{skip};

my $lang = $config->{pod_spelling_hunspell}->{lang} || 'Alien::Hunspell::EN::US';
skip_all "test requires $lang" unless eval qq{ require $lang; 1 };
skip_all "test requires Dist::Zilla::PluginBundle::Author::Plicease 1.97"
  unless Dist::Zilla::PluginBundle::Author::Plicease->can('dist_dir');

my @lang = (
  $lang->aff_file,
  $lang->dic_file,
  Dist::Zilla::PluginBundle::Author::Plicease->dist_dir->file('extra.dic'),
);

my $dist_dic = File::Spec->catfile(
  $FindBin::Bin, 'release.dic',
);

push @lang, $dist_dic if -r $dist_dic;

set_language_files(@lang);

plan 1;

pod_file_spelling_ok 'lib/Test/Spelling/Hunspell.pm';
