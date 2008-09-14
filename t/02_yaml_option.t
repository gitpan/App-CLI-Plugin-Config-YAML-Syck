#!/usr/bin/perl

use strict;
use Test::More tests => 1;
use lib qw(t/lib);
use MyCLIConfigOption;

our $RESULT;

my $result = {a => "var", b => {a => 1, b => 2, c => 3}, c => ["a", "b", "c"]};

{
    local *ARGV = ["yaml", "--config_file=t/etc/config.yaml"];
    MyCLIConfigOption->dispatch;
}

is_deeply($result, $RESULT);

