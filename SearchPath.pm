package Win32::SearchPath;

use 5.008000;
use strict;
use warnings;

require Exporter;
use AutoLoader qw(AUTOLOAD);

our @ISA = qw(Exporter);
our @EXPORT = qw( SearchPath );

our $VERSION = '0.01';

require XSLoader;
XSLoader::load('Win32::SearchPath', $VERSION);



1;
__END__

# Below is documentation for the module.

=head1 NAME

Win32::SearchPath - Perl extension for the Win32 API SearchPath, and 
filename extension association resolution.

=head1 SYNOPSIS

  use Win32::SearchPath;

  $FullPath = SearchPath ('perl');

=head1 DESCRIPTION

This module is specifically for use with Win32::Process::Create.  That interface
requires the full path name of the executable, which SearchPath provides.

   $FULL_PATH = SearchPath(FILENAME)

Search for the specified FILENAME.  By default the extension ".exe" is added to 
FILENAME, but this is ignored if it already has an extension.

The SearchPath API searches directories in the same order as code is loaded by the  
operating system (dll's and exe's), which is:

   1.  The directory from which the application was loaded ($Config{perlpath}).
   2.  The current directory.
   3.  The Windows system directory (SYSTEM32 on NT, 2000, XP, et al)
   4.  The 16-bit Windows system directory (named SYSTEM, largely obsolete).
   5.  The 'top level' Windows directory, in $ENV{SystemRoot}.
   6.  Finally it searches directories in the Path environment variable.

Although non-executable files can be searched for in this way, it is not really 
suitable for anything other than finding executables (although see array context below).

In the event of an error undef is returned, in which case variable $^E ($EXTENDED_OS_ERROR) 
should be checked, not $! ($OS_ERROR).


=head2 EXPORT

SearchPath

=head1 SEE ALSO

Win32::Process
Win32::API provides a generic interface to APIs in kernel32.dll
File::Which is similar to the basic SearchPath API, but only searches directories 
in %Path% (so says the doc)

SearchPath API in the MSDN

=head1 AUTHOR

Clive Darke, E<lt>clive.darke@talk21.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2004 by Clive Darke

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.0 or,
at your option, any later version of Perl 5 you may have available.


=cut
