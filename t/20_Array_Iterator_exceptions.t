#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 11;
use Test::Exception;

BEGIN { 
    use_ok('Array::Iterator') 
};

# test the exceptions

# test that the constructor cannot be empty
throws_ok {
    my $i = Array::Iterator->new();
} qr/^Insufficient Arguments \: you must provide an array to iterate over/, 
  '... we got the error we expected';

# check that it does not allow non-array ref paramaters
throws_ok {
    my $i = Array::Iterator->new({});
} qr/^Incorrect Type \: the argument must be an array reference/, 
  '... we got the error we expected';

# or single element arrays (cause they make no sense)
throws_ok {
    my $i = Array::Iterator->new(1);
} qr/^Incorrect Type \: the argument must be an array reference/, 
  '... we got the error we expected';

throws_ok {
		Array::Iterator->_init(undef, 1);
} qr/^Insufficient Arguments \: you must provide an length and an iteratee/,
  '... we got the error we expected';

throws_ok {
		Array::Iterator->_init(1);
} qr/^Insufficient Arguments \: you must provide an length and an iteratee/,
  '... we got the error we expected';
  
# now test the next & peek exceptions

my @control = (1 .. 5);
my $iterator = Array::Iterator->new(@control);
isa_ok($iterator, 'Array::Iterator');

my @_control;
push @_control => $iterator->next() while $iterator->hasNext();

ok(!$iterator->hasNext());
ok(eq_array(\@control, \@_control), '.. make sure all are exhausted');

# test that next will croak if it is called passed the end
throws_ok {
    $iterator->next();
} qr/^Out Of Bounds \: no more elements/, 
  '... we got the error we expected';

# test that peek will croak if it is called passed the end
throws_ok {
    $iterator->peek();
} qr/^Out Of Bounds \: cannot peek past the end of the array/, 
  '... we got the error we expected';

