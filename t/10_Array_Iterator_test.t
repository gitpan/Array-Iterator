#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 47;

BEGIN { 
    use_ok('Array::Iterator') 
};

my @control = (1 .. 5);

can_ok("Array::Iterator", 'new');
my $iterator = Array::Iterator->new(@control);

isa_ok($iterator, 'Array::Iterator');

# check my private methods
can_ok($iterator, '_init');
can_ok($iterator, '_getItem');

# check out public methods
can_ok($iterator, 'hasNext');
can_ok($iterator, 'next');
can_ok($iterator, 'peek');
can_ok($iterator, 'getNext');
can_ok($iterator, 'current');
can_ok($iterator, 'currentIndex');

# now check the behavior

for (my $i = 0; $i < scalar @control; $i++) {
    # we should still have another one
    ok($iterator->hasNext());
    # and out iterator peek should match our control + 1    
    unless (($i + 1) >= scalar @control) {
        cmp_ok($iterator->peek(), '==', $control[$i + 1], 
               '... our control should match our iterator->peek');
    }
    else {
        ok(!defined($iterator->peek()), '... this should return undef now');
    }
    # and out iterator should match our control 
    cmp_ok($iterator->next(), '==', $control[$i], 
           '... our control should match our iterator->next');
}

# we should have no more 
ok(!$iterator->hasNext(), '... we should have no more');

# now use an array ref in the constructor 
# and try using it in this style loop
for (my $i = Array::Iterator->new(\@control); $i->hasNext(); $i->next()) {
	cmp_ok($i->current(), '==', $control[$i->currentIndex()], '... these should be equal');
}

# we should have no more 
ok(!$iterator->hasNext(), '... we should have no more');

my $iterator2 = Array::Iterator->new(@control);
my @acc;
push @acc, => $iterator2->next() while $iterator2->hasNext();

# our accumulation and control should be the same
ok(eq_array(\@acc, \@control), '... these arrays should be equal');

# we should have no more 
ok(!$iterator->hasNext(), '... we should have no more');

my $i3 = Array::Iterator->new(\@control);

my $current;
while ($current = $i3->getNext()) {
    cmp_ok($current, '==', $control[$i3->currentIndex()], '... these should be equal (getNext)');
    cmp_ok($current, '==', $i3->current(), '... these should be equal (getNext)');
}

ok(!defined($iterator->getNext()), '... we should get undef');

# we should have no more 
ok(!$iterator->hasNext(), '... we should have no more');

