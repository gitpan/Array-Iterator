
package Array::Iterator::BiDirectional;

use strict;
use warnings;

our $VERSION = '0.01';

use Array::Iterator;
our @ISA = qw(Array::Iterator);

sub hasPrevious {
	my ($self) = @_;
	return (($self->_current_index - 1) > 0) ? 1 : 0;
}

sub previous {
	my ($self) = @_;
    (($self->_current_index - 1) > 0) 
        || die "Out Of Bounds : no more elements";    
	return $self->_getItem($self->_iteratee, --$self->_current_index);
}

sub getPrevious {
	my ($self) = @_;
    return undef unless (($self->_current_index - 1) > 0);    
	return $self->_getItem($self->_iteratee, --$self->_current_index);
}

sub lookBack {
	my ($self) = @_;
    return undef unless (($self->_current_index - 2) > 0);
	return $self->_getItem($self->_iteratee, ($self->_current_index - 2));
}


1;
__END__

=head1 NAME

Array::Iterator::BiDirectional - A subclass of Array::Iterator to allow forwards and backwards iteration

=head1 SYNOPSIS

  use Array::Iterator::BiDirectional;
  
  # create an instance of the iterator
  my $i = Array::Iterator::BiDirectional->new(1 .. 100);
  
  while ($some_condition_exists) {
      # get the latest item from 
      # the iterator
      my $current = $i->getNext();
      # ...
      if ($something_happens) {
          # back up the iterator 
          $current = $i->getPrevious();
      }
  }

=head1 DESCRIPTION

Occasionally it is useful for an iterator to go in both directions, forward and backward. One example would be token processing. When looping though tokens it is sometimes necessary to advance forward looking for a match to a rule. If the match fails, a bi-directional iterator can be moved back so that the next rule can be tried. 

=head1 METHODS

This is a subclass of Array::Iterator, only those methods that have been added are documented here, refer to the Array::Iterator documentation for more information.

=over 4

=item B<hasPrevious>

This method works much like C<isNext> does, it will return true (C<1>) unless the begining of the array has been reached, and false (C<0>) otherwise. 

=item B<previous>

This method is much like C<next>. It will return the previous item in the iterator, and throw an exception if it attempts to reach past the begining of the array.

=item B<getPrevious>

This method is much like C<getNext>. It will return the previous item in the iterator, and return undef if it attempts to reach past the begining of the array.

=item B<lookBack>

This is the counterpart to C<peek>, it will return the previous items in the iterator, but will not affect the internal counter.

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
