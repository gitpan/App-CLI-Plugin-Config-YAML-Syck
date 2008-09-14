package MyCLIConfigOption;

use strict;
use base qw(App::CLI::Extension);
use constant alias => ("yaml" => "YAMLTest");

__PACKAGE__->load_plugins(qw(Config::YAML::Syck));

1;

