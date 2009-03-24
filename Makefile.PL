#!/usr/bin/env perl
use warnings;
use strict;

use vars qw( $VERSION );

# $Id: Makefile.PL 94 2008-02-27 23:17:04Z abuse $
$VERSION = do {
  my @r=(q$Revision: 94 $=~/\d+/g); sprintf "%d."."%03d"x$#r,@r
};

use ExtUtils::MakeMaker;
eval "use ExtUtils::MakeMaker::Coverage";
warn "Note: ExtUtils::MakeMaker::Coverage not available, can't 'make testcover'\n"
  if $@;

WriteMakefile(
              ABSTRACT => 'Extensible package-local way to override glob()',
	      NAME     => 'Acme::Globule',
	      VERSION  => '0.001',
              PREREQ_PM => {
			    # required by Acme::Globule::Range
                            'Regexp::Common' => undef,
                           },
	     );
