# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 4 };
use VMS::FindFile;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my ($ff, $dir_fname, $ff_fname, $compare_ok);

$ff = VMS::FindFile->new("[]*.*;") || die
   "Couldn't create VMS::FindFile object\n";
ok(1); # created new FindFile object OK

open IN, "dir/nohe/notr []*.*; |" || die "Couldn't open pipe\n";

$compare_ok = 1;

while (<IN>) {
   $dir_fname = $_;
   chomp $dir_fname;
   $ff_fname = $ff->search();
   if ($dir_fname ne $ff_fname) {
      $compare_ok = 0;
      last;
   }
}
ok($compare_ok);
ok($ff_fname eq "");
close IN;
