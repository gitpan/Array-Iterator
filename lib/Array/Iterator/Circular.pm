
package Array::Iterator::Circular;

use strict;
use warnings;

our $VERSION = '0.01';

use Array::Iterator;
our @ISA = qw(Array::Iterator);

sub _init {
    my ($self, @args) = @_;
    $self->{loop_counter} = 0;
    $self->SUPER::_init(@args);
}

# always return true, since 
# we just keep looping
sub hasNext { 1 }

sub next {
	my ($self) = @_;
    unless ($self->_current_index < $self->getLength()) {
        $self->_current_index = 0; 
        $self->{loop_counter}++;
    }
	return $self->_getItem($self->_iteratee(), $self->_current_index++);
}

# since neither of them will 
# ever stop dispensing items
# they can just be aliases of 
# one another.
*getNext = \&next;

sub isStart {
    my ($self) = @_;
    return ($self->_current_index() == 0);
}

sub isEnd {
    my ($self) = @_;
    return ($self->_current_index() == $self->getLength());
}

sub getLoopCount {
    my ($self) = @_;
    return $self->{loop_counter};
}

1;
__END__

=head1 NAME

Array::Iterator::Circular - A subclass of Array::Iterator to allow circular iteration

=head1 SYNOPSIS

  use Array::Iterator::Circular;
  
  # create an instance with a
  # small array
  my $color_iterator = Array::Iterator::Circular->new(qw(red green blue orange));
  
  # this is a large list of 
  # arbitrary items
  my @long_list_of_items = ( ... ); 
  
  # as we loop through the items ...
  foreach my $item (@long_list_of_items) {
      # we assign color from our color
      # iterator, which will keep dispensing
      # as it loops through its set
      $item->setColor($color_iterator->next());
  }
  
  # tell us how many times the set
  # was looped through
  print $color_iterator->getLoopCount();

=head1 DESCRIPTION

This iterator will loop continuosly as long as C<next> or C<getNext> is called. The C<hasNext> method will always return true (C<1>), since the list will always loop back. This is useful when you need a list to repeat itself, but don't want to (or care to) know that it is doing so. 

=head1 METHODS

This is a subclass of Array::Iterator, only those methods that have been added or altered are documented here, refer to the Array::Iterator documentation for more information.

=over 4

=item B<hasNext>

Since we endlessly loop, this will always return true (C<1>).

=item B<next>

This will return the next item in the array, and when it reaches the end of the array, it will loop back to the begining again.

=item B<getNext>

This method is now defined in terms of C<next>, since neither will even stop dispensing items, there is no need to differentiate.

=item B<isStart>

If at anytime during your looping, you want to know if you have arrived back at the start of you list, you can ask this method.

=item B<isEnd>

If at anytime during your looping, you want to know if you have gotten to the end of you list, you can ask this method.

=item B<getLoopCount>

This method will tell you how many times the iterator has looped back to its start.

=back

=head1 BUGS

None that I am aware of, if you find a bug, let me know, and I will be sure to fix it. 

=head1 CODE COVERAGE

See the B<CODE COVERAGE> section of the B<Array::Iterator> documentation for information about the code coverage of this module's test suite.

=head1 SEE ALSO

This is a subclass of B<Array::Iterator>, please refer to it for more documenation.

=head1 AUTHOR

stevan little, E<lt>stevan@iinteractive.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2004 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
