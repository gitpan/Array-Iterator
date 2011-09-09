
package Array::Iterator::BiDirectional;

use strict;
use warnings;

our $VERSION = '0.07'; # VERSION

use Array::Iterator;
our @ISA = qw(Array::Iterator);

sub has_previous {
	my ($self) = @_;
	return (($self->_current_index - 1) > 0) ? 1 : 0;
}

sub hasPrevious { my $self = shift; $self->has_previous(@_) }

sub previous {
	my ($self) = @_;
    (($self->_current_index - 1) > 0)
        || die "Out Of Bounds : no more elements";
        $self->_iterated = 1;
	return $self->_getItem($self->_iteratee, --$self->_current_index);
}

sub get_previous {
	my ($self) = @_;
    return undef unless (($self->_current_index - 1) > 0);
        $self->_iterated = 1;
	return $self->_getItem($self->_iteratee, --$self->_current_index);
}

sub getPrevious { my $self = shift; $self->get_previous(@_) }

sub look_back {
	my ($self) = @_;
    return undef unless (($self->_current_index - 2) > 0);
        $self->_iterated = 1;
	return $self->_getItem($self->_iteratee, ($self->_current_index - 2));
}

sub lookBack { my $self = shift; $self->look_back(@_) }

1;
#ABSTRACT: A subclass of Array::Iterator to allow forwards and backwards iteration


=pod

=head1 NAME

Array::Iterator::BiDirectional - A subclass of Array::Iterator to allow forwards and backwards iteration

=head1 VERSION

version 0.07

=head1 SYNOPSIS

  use Array::Iterator::BiDirectional;

  # create an instance of the iterator
  my $i = Array::Iterator::BiDirectional->new(1 .. 100);

  while ($some_condition_exists) {
      # get the latest item from
      # the iterator
      my $current = $i->get_next();
      # ...
      if ($something_happens) {
          # back up the iterator
          $current = $i->get_previous();
      }
  }

=head1 DESCRIPTION

Occasionally it is useful for an iterator to go in both directions, forward and backward. One example would be token processing. When looping though tokens it is sometimes necessary to advance forward looking for a match to a rule. If the match fails, a bi-directional iterator can be moved back so that the next rule can be tried.

=head1 METHODS

This is a subclass of Array::Iterator, only those methods that have been added are documented here, refer to the Array::Iterator documentation for more information.

=over 4

=item B<has_previous>

This method works much like C<isNext> does, it will return true (C<1>) unless the begining of the array has been reached, and false (C<0>) otherwise.

=item B<previous>

This method is much like C<next>. It will return the previous item in the iterator, and throw an exception if it attempts to reach past the begining of the array.

=item B<get_previous>

This method is much like C<get_next>. It will return the previous item in the iterator, and return undef if it attempts to reach past the begining of the array.

=item B<look_back>

This is the counterpart to C<peek>, it will return the previous items in the iterator, but will not affect the internal counter.

=back

=head1 BUGS

None that I am aware of, if you find a bug, let me know, and I will be sure to fix it.

=head1 CODE COVERAGE

See the B<CODE COVERAGE> section of the B<Array::Iterator> documentation for information about the code coverage of this module's test suite.

=head1 SEE ALSO

This is a subclass of B<Array::Iterator>, please refer to it for more documenation.

=head1 ORIGINAL AUTHOR

stevan little, E<lt>stevan@iinteractive.comE<gt>

=head1 ORIGINAL COPYRIGHT AND LICENSE

Copyright 2004 by Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

