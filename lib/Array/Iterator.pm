package Array::Iterator;

use strict;
use warnings;

our $VERSION = '0.02';

### constructor

sub new {
	my ($_class, @array) = @_;
	(@array) 
        || die "Insufficient Arguments : you must provide an array to iterate over";
	my $class = ref($_class) || $_class;
	my $_array;
	if (scalar @array == 1) {
        (ref($array[0]) eq "ARRAY") 
            || die "Incorrect Type : the argument must be an array reference"; 
		$_array = $array[0];
	}
	else {
		$_array = \@array;
	}
	my $iterator = {
        _current_index => 0,
        _length => 0,
        _iteratee => []
        };
	bless($iterator, $class);
	$iterator->_init(scalar(@{$_array}), $_array);
	return $iterator;
}

### methods

# private methods

sub _init {
	my ($self, $length, $iteratee) = @_;
	(defined($length) && defined($iteratee)) 
        || die "Insufficient Arguments : you must provide an length and an iteratee";
	$self->{_current_index} = 0;
	$self->{_length} = $length;
	$self->{_iteratee} = $iteratee;
}

sub _getItem {
	my ($self, $iteratee, $index) = @_;
	return $iteratee->[$index];
}

# public methods

# this defines the minimal interface
# an iterator object will have
	
sub hasNext {
	my ($self) = @_;
	return ($self->{_current_index} < $self->{_length}) ? 1 : 0;
}

sub next {
	my ($self) = @_;
    ($self->{_current_index} < $self->{_length}) 
        || die "Out Of Bounds : no more elements";    
	return $self->_getItem($self->{_iteratee}, $self->{_current_index}++);
}

sub peek {
	my ($self) = @_;
    (($self->{_current_index} + 1) < $self->{_length}) 
        || die "Out Of Bounds : cannot peek past the end of the array";
	return $self->_getItem($self->{_iteratee}, ($self->{_current_index} + 1));
}

sub current {
	my ($self) = @_;
	return $self->_getItem($self->{_iteratee}, $self->{_current_index});	
}

1;
__END__

=head1 NAME

Array::Iterator - A simple Iterator class for iterating over Perl arrays

=head1 SYNOPSIS

  use Array::Iterator;
  
  # create an iterator with an array
  my $i = Array::Iterator->new(1 .. 100);
  
  # create an iterator with an array reference
  my $i = Array::Iterator->new(\@array);
  
  # a simple loop 
  while ($i->hasNext()) {
      if ($i->peek() < 50) {
          # ... do something because 
          # the next element is over 50
      }
      my $current = $i->next();
      # ... do something with current
  }
  
  # shortcut style
  my @accumulation;
  push @accumulation => { item => $iterator->next() } while $iterator->hasNext();
  
  # C++ ish style iterator
  for (my $i = Array::Iterator->new(@array); $i->hasNext(); $i->next()) {
    my $current = $i->current();
    # .. do something with current
  }

=head1 DESCRIPTION

This class provides a very simple iterator interface. It is is uni-directional and can only be used once. It provides no means of reverseing or reseting the iterator. It is not recommended to alter the array during iteration, however no attempt is made to enforce this (although I will if I can find an efficient means of doing so). This class only intends to provide a clear and simple means of generic iteration, nothing more (yet).

This is the 0.02 release of this module, but it has been in use now for about a year in production systems without issue. I plan on releasing a few more versions of this code as I tweak and test it more before I will consider it 1.0, but it can be considered reasonable stable for production use if you like. 

=head1 METHODS

=head2 Public Methods

=over 4

=item B<new (@array | $array_ref)>

The constructor can be passed either a plain perl array or an array reference. Single element arrays are not allowed, as they do not make sense anyway. An exception will be thrown if any of the following conditions are meet; a single element array is given, a non-array reference is given.

=item B<hasNext>

This methods returns a boolean. True (1) if there are still more elements in the iterator, false (0) if there are not.

=item B<next>

This method returns the next item in the iterator, be sure to only call this once per iteration as it will advance the index pointer to the next item. If this method is called after all elements have been exhausted, an exception will be thrown.

=item B<peek>

This method can be used to peek ahead at the next item in the iterator. It is non-destructuve, meaning it does not advance the internal pointer. If this method is called and attempts to reach beyond the bounds of the iterator, an exception will be thrown.

=item B<current>

This method can be used to get the current item in the iterator. It is non-destructive, meaning that it does now advance the internal pointer. 

=back

=head2 Private Methods

These methods are not to be used publically, and are documented here for those who want to extend this class.

=over 4

=item B<_init ($length, $iteratee)>

This method simply places the item to iterate over (C<$iteratee>) and its calculated length (C<$length>) into slots that C<hasNext>, C<next> and C<peek> expect to find them. 

=item B<_getItem ($iteratee, $index)>

This method handles all the element accessing. It takes an iteratee and and index, and returns the item found at that index.

=back

=head1 BUGS

None that I am aware of. The code is pretty thoroughly tested (see L<CODE COVERAGE> below) and is based on an (non-publicly released) module which I had used in production systems for about 1 year without incident. Of course, if you find a bug, let me know, and I will be sure to fix it. 

=head1 CODE COVERAGE

I use B<Devel::Cover> to test the code coverage of my tests, below is the B<Devel::Cover> report on this module's test suite.

 -------------------------------- ------ ------ ------ ------ ------ ------ ------
 File                               stmt branch   cond    sub    pod   time  total
 -------------------------------- ------ ------ ------ ------ ------ ------ ------
 /Array/Iterator.pm                100.0  100.0   66.7  100.0  100.0    8.7   96.8
 t/10_Array_Iterator_test.t        100.0  100.0    n/a    n/a    n/a  100.0  100.0
 t/20_Array_Iterator_exceptions.t  100.0    n/a    n/a  100.0    n/a   25.6  100.0
 -------------------------------- ------ ------ ------ ------ ------ ------ ------
 Total                             100.0  100.0   66.7  100.0  100.0  100.0   98.3
 -------------------------------- ------ ------ ------ ------ ------ ------ ------

=head1 SEE ALSO

Gang Of Four Design Patterns Book. Specifically the Iterator pattern.

The interface for this Iterator is based upon the Java Iterator interface.

There are other modules out there that do similar things, if you don't happen to like the way I do it.

=over 4

=item B<Data::Iter>

=item B<Class::Iterator>

=back

=head1 AUTHOR

stevan little, E<lt>stevan@iinteractive.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2004 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
