
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Win32-SearchPath.t'

#########################

use Config;

use Test::More tests => 7;

BEGIN { use_ok('Win32::SearchPath') };

#########################

# Sanity check
is($^O, 'MSWin32', 'OS is Windows');

# Basic check, we know this is here!
my $FullPath = SearchPath ('perl');
is($FullPath, $Config{'perlpath'},'perl path check');

# Let's hope the user
$FullPath = SearchPath ('garbage.xyz');
my $Err = $^E;    # Save current error, it gets changed by the tests
is($FullPath, undef, 'unknown file');
ok($Err == 2, 'check os error number');   # 2: see winerror.h

# Can't really check the returned path, in theory it could be anywhere
# All we can check is that it found it
$FullPath = SearchPath ('kernel32.dll');
ok($FullPath, 'check non-.exe extension 1');

$FullPath = SearchPath ('config.pl');
ok($FullPath, 'check non-.exe extension 2');

