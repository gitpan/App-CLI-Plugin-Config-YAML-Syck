package MyApp;

use strict;
use base qw(App::CLI::Extension);
use constant alias => ("yaml" => "YAMLTest");

__PACKAGE__->load_plugins(qw(Config::YAML::Syck));
__PACKAGE__->config(config_file => "t/etc/config.yaml");

1;

