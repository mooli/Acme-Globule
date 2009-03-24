package Acme::Globule::Range;

use Regexp::Common; #FIXME: don't forget to add to prerequisites
my $num = $RE{num}{int};

sub _range($$$) {
  my($first, $last, $step) = @_;
  #warn "$first..$last (step $step)\n";
  my @range;
  if($step > 0) {
    while($first <= $last) {
      push @range, $first;
      $first += $step;
    }
  } elsif($step < 0) {
    while($first >= $last) {
      push @range, $first;
      $first += $step;
    }
  } else {
    return [ $first ];
  }
  return \@range;
}

sub globule {
  my($self, $pattern) = @_;
  local $_ = $pattern;
  if(/^($num)\.\.($num)$/) {
    if($1 < $2) {
      return _range $1, $2, 1;
    } elsif ($1 > $2) {
      return _range $1, $2, -1;
    } else {
      return [ $1 ];
    }
  } elsif(/^($num),($num)\.\.($num)$/) {
    return _range $1, $3, $2-$1;
  } elsif(/^($num)\.\.($num),($num)$/) {
    return _range $1, $3, $3-$2;
  } else {
    return;
  }
}

=head1 NAME

Acme::Globule::Range - alternative range operator

=head1 SYNOPSIS

 use Acme::Globule qw( Range );

 foreach (<10..1>) {
   print "$_... ";
 }
 print "Lift-off!\n";

 # put down that crack pipe...
 sub my_keys(\%) {
   my @hash = %{ $_[0] };
  return @hash[ glob("0,2..$#hash") ];
 }

 sub my_values(\%) {
   my @hash = %{ $_[0] };
  return @hash[ glob("1,3..$#hash") ];
 }

=head1 DESCRIPTION

This is a Acme::Globule plugin that makes glob() do range operations. The
following range formats are supported:

=over 4

=item C<A..Z>

Returns the integers between A and Z. If Z is lower than A, this will return
a reversed range. Thus C<E<lt>1..9E<gt>> is C<(1..9)> and C<E<lt>9..1E<gt>>
is C<(reverse 1..9)>.

=item C<A,B..Z>

Returns the integers between A and Z with a step such that the second value
is B. Thus C<E<lt>1,3..9E<gt>> is C<(1, 3, 5, 7, 9)>.

=item C<A..Y,Z>

Returns the integers between A and Z with a step such that the next to last
value is Y. Thus C<E<lt>1..7,9E<gt>> is C<(1, 3, 5, 7, 9)>.

=back

Any other string will fall through to the next plugin.

=head1 BUGS

=head1 SEE ALSO

Acme::Range and List::Maker, although these are somewhat broken because they
replace glob() globally.

=head1 AUTHOR

All code and documentation by Peter Corlett <abuse@cabal.org.uk>.

=head1 COPYRIGHT

Copyright (C) 2008 Peter Corlett <abuse@cabal.org.uk>. All rights
reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SUPPORT / WARRANTY

This is free software. IT COMES WITHOUT WARRANTY OF ANY KIND.

=cut

1;
