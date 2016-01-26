# Test::Spelling::Hunspell [![Build Status](https://secure.travis-ci.org/plicease/Test-Spelling-Hunspell.png)](http://travis-ci.org/plicease/Test-Spelling-Hunspell)

Check for spelling errors in POD files using hunspell

# SYNOPSIS

    use Test::Stream -V1;
    use Test::Spelling::Hunspell;
    use Alien::Hunspell::EN::US;
    
    plan 1;
    set_language_files(
      Alien::Hunspell::EN::US->aff_file,
      Alien::Hunspell::EN::US->dic_file,
    );
    
    pod_file_spelling_ok 'lib/Foo/Bar.pm';

# DESCRIPTION

Test POD Files for spelling errors using Hunspell (either via
[Text::Hunspell](https://metacpan.org/pod/Text::Hunspell) or [Text::Hunspell::FFI](https://metacpan.org/pod/Text::Hunspell::FFI)).

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

# FUNCTIONS

## pod\_file\_spelling\_ok

    pod_file_spelling_ok $pod_filename;
    pod_file_spelling_ok $pod_filename, $test_name;

Passes if the given POD file has no spelling errors.

## set\_language\_files

    set_language_files $aff_file, @dic_files;

Sets the affix and "dictionary" word list files.  This can be obtained 
using [Alien::Hunspell::EN::US](https://metacpan.org/pod/Alien::Hunspell::EN::US), [Alien::Hunspell::EN::AU](https://metacpan.org/pod/Alien::Hunspell::EN::AU), or perhaps 
from your operating system.

You must specify exactly one affix file and at least one dictionary 
files.

## set\_pod\_parser

    set_pod_parser $parser_class;

Set the parser used to extract words from POD.  This is [Pod::Spell](https://metacpan.org/pod/Pod::Spell) by 
default.

# SEE ALSO

- [Test::Spelling](https://metacpan.org/pod/Test::Spelling)
- [Test::Pod::Spelling](https://metacpan.org/pod/Test::Pod::Spelling)
- [Text::Hunspell](https://metacpan.org/pod/Text::Hunspell)
- [Text::Hunspell::FFI](https://metacpan.org/pod/Text::Hunspell::FFI)

# AUTHOR

Graham Ollis &lt;plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
