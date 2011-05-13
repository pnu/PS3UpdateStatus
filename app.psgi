#!/usr/bin/env perl
use strict;
use warnings;
use lib 'lib';
use PS3UpdateStatus;
use Plack::Builder;

PS3UpdateStatus->setup_engine('PSGI');
my $app = sub { PS3UpdateStatus->run(@_) };

builder {
    $app;
};

