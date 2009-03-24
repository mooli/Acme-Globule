#!/usr/bin/env perl
use warnings;
use strict;

use vars qw( $VERSION );

# $Id: Makefile.PL 120 2008-03-03 00:35:57Z abuse $
$VERSION = do {
  my @r=(q$Revision: 120 $=~/\d+/g); sprintf "%d."."%03d"x$#r,@r
};

use ExtUtils::MakeMaker;
eval "use ExtUtils::MakeMaker::Coverage";
warn "Note: ExtUtils::MakeMaker::Coverage not available, can't 'make testcover'\n"
  if $@;

WriteMakefile(
              ABSTRACT => 'Extensible package-local way to override glob()',
	      NAME     => 'Acme::Globule',
	      VERSION  => '0.003',

              PREREQ_PM => {
                            # We wedge ourselves into File::Glob, which is
                            # how glob() is implemented from Perl 5.6
                            # onwards.
                            'File::Glob' => undef,

			    # required by Acme::Globule::Range
                            'Regexp::Common' => undef,
                           },
	     );
