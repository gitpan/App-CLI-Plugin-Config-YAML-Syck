package MyAppOption::YAMLTest;

use strict;
use base qw(App::CLI::Command);
use constant options => ("config_file=s" => "config_file");

sub run {

    my($self, @args) = @_;
    $main::RESULT = $self->config;
}
1;

