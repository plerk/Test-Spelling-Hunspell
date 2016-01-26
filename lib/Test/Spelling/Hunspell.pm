package Test::Spelling::Hunspell;

use strict;
use warnings;
use utf8;
use 5.020;
use experimental qw( signatures postderef );
use Test::Stream::Context qw( context );
use Test::Stream::Exporter;
default_exports qw( set_pod_parser set_language_files pod_file_spelling_ok );
no Test::Stream::Exporter;
use Module::Load qw( load );
use Carp qw( croak );

# ABSTRACT: Check for spelling errors in POD files using Hunspell
# VERSION

=head1 SYNOPSIS

 use Test::Stream -V1;
 use Test::Spelling::Hunspell;
 use Alien::Hunspell::EN::US;
 
 plan 1;
 set_language_files(
   Alien::Hunspell::EN::US->aff_file,
   Alien::Hunspell::EN::US->dic_file,
 );
 
 pod_file_spelling_ok 'lib/Foo/Bar.pm';

=head1 DESCRIPTION

Test POD Files for spelling errors using Hunspell (either via
L<Text::Hunspell> or L<Text::Hunspell::FFI>).

There are already a few spell checking modules on CPAN, but most
either look for very specific sort of spelling errors, or use a
variety of different checkers depending on what is available.
This module is intended to be a little more repeatable, by
requiring a specific dictionary / word list be specified, and
by only working with a recent version of Hunspell.

This module should still only be used as a developer test, but
hopes to be a little less annoying for a developer like me who
switches between many different platforms and configurations
and wants a test that is a little more consistent.

=head1 FUNCTIONS

=head2 pod_file_spelling_ok

 pod_file_spelling_ok $pod_filename;
 pod_file_spelling_ok $pod_filename, $test_name;

Passes if the given POD file has no spelling errors.

=cut

sub pod_file_spelling_ok ($file, $name = "POD spelling for $file")
{
  my $ok = 1;

  my @diag;
  if(!-r $file)
  {
    $ok = 0;
    push @diag, "$file does not exist or is unreadable";
  }
  else
  {
    my $document = '';
    open my $outfh, '>', \$document;
    binmode $outfh, ':utf8';
    open my $infh, '<', $file;
    binmode $infh, ':utf8';
    _get_pod_parser()->parse_from_filehandle($infh, $outfh);
    close $infh;
    close $outfh;
    my %count;
    my @words = grep { !$count{$_}++ } grep !/^\s*$/, split /\s+/, $document;

    my $speller = _get_hunspell();
    
    foreach my $word (@words)
    {
      next if $speller->check($word);
      $ok = 0;
      push @diag, "  mispelled: '$word'" . ($count{$word} > 1 ? " [ x $count{$word} ]" : '');;
      push @diag, "    suggestion: $_" for $speller->suggest($word);
    }
  }

  my $context = context();
  $context->ok($ok, $name);
  $context->diag($_) for @diag;
  $context->release;
  
  $ok;
}

=head2 set_language_files

 set_language_files $aff_file, @dic_files;

Sets the affix and "dictionary" word list files.  This can be obtained 
using L<Alien::Hunspell::EN::US>, L<Alien::Hunspell::EN::AU>, or perhaps 
from your operating system.

You must specify exactly one affix file and at least one dictionary 
files.

=cut

# first entry is the affix file,
# the second is the main dictionary
# subsequent entires are additional
# dictionaries.
my @lang;

sub set_language_files ($aff, $dic, @rest)
{
  @lang = ($aff, $dic, @rest);
}


sub _get_hunspell ()
{
  croak "must specify affic and dictionary files with set_language_files"
    unless @lang >= 2;
  foreach my $try (qw( Text::Hunspell::FFI Text::Hunspell ))
  {
    if($try->can('new') || eval { load $try; 1 })
    {
      my($aff, $dic, @rest) = @lang;
      my $spell = $try->new($aff, $dic);
      $spell->add_dic($_) for @rest;
      return $spell;
    }
  }
  
  die "No appropriate speller installed.  Please install Text::Hunspell::FFI or Text::Hunspell";
}

=head2 set_pod_parser

 set_pod_parser $parser_class;

Set the parser used to extract words from POD.  This is L<Pod::Spell> by 
default.

=cut

my $parser_class = 'Pod::Spell';

sub set_pod_parser ($class)
{
  $parser_class = $class;
}

sub _get_pod_parser ()
{
  load $parser_class unless $parser_class->can('new');
  $parser_class->new;
}


=head1 SEE ALSO

=over 4

=item L<Test::Spelling>

=item L<Test::Pod::Spelling>

=item L<Text::Hunspell>

=item L<Text::Hunspell::FFI>

=back

=cut

1;
