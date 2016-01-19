# Test::Spelling::Hunspell [![Build Status](https://secure.travis-ci.org/plicease/Test-Spelling-Hunspell.png)](http://travis-ci.org/plicease/Test-Spelling-Hunspell)

Check for spelling errors in POD files using hunspell

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

TODO

## set\_language\_files

TODO

## get\_hunspell

TODO

## set\_pod\_parser

TODO

## get\_pod\_parser

TODO

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
