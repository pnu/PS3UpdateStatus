#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use Catalyst::Test 'PS3UpdateStatus';

ok( request('/')->is_success, 'Request should succeed' );

done_testing();
