#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 32;
use Test::Exception;

BEGIN {
    use_ok('Array::Iterator::BiDirectional')
};

my @control = (1 .. 5);

can_ok("Array::Iterator::BiDirectional", 'new');
my $iterator = Array::Iterator::BiDirectional->new(@control);

isa_ok($iterator, 'Array::Iterator::BiDirectional');
isa_ok($iterator, 'Array::Iterator');

# check out public methods
can_ok($iterator, 'hasPrevious');
can_ok($iterator, 'has_previous');
can_ok($iterator, 'previous');
can_ok($iterator, 'lookBack');
can_ok($iterator, 'look_back');
can_ok($iterator, 'getPrevious');
can_ok($iterator, 'get_previous');

# now check the behavior

# move our counter to the end
$iterator->next() while $iterator->hasNext();

for (my $i = $#control; $i > 0; $i--) {
    # we should still have another one
    ok($iterator->hasPrevious(), '... we have some previous items');
    # and out iterator peek should match our control + 1
    unless (($i - 1) <= 0) {
        cmp_ok($iterator->lookBack(), '==', $control[$i - 1],
               '... our control should match our iterator->lookBack');
    }
    else {
        ok(!defined($iterator->lookBack()), '... this should return undef now');
    }
    # and out iterator should match our control
    cmp_ok($iterator->previous(), '==', $control[$i],
           '... our control should match our iterator->previous');
}

# we should have no more
ok(!$iterator->hasPrevious(), '... we should have no more');

# now use an array ref in the constructor
# and try using it in this style loop
my $iterator2 = Array::Iterator::BiDirectional->new(\@control);

isa_ok($iterator2, 'Array::Iterator::BiDirectional');
isa_ok($iterator2, 'Array::Iterator');

# move our iterator to the end
$iterator2->next() while $iterator2->hasNext();

for (my $i = $iterator2; $i->hasPrevious(); $i->getPrevious()) {
	cmp_ok($i->current(), '==', $control[$i->currentIndex()], '... these should be equal');
}

ok(!defined($iterator2->getPrevious()), '... this should return undef');

throws_ok {
    $iterator2->previous();
} qr/Out Of Bounds \: no more elements/, '... this should die if i try again';





