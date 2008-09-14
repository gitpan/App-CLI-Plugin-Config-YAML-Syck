package App::CLI::Plugin::Config::YAML::Syck;

=pod

=head1 NAME

App::CLI::Plugin::YAML::Syck - for App::CLI::Extension config plugin module

=head1 VERSION

0.01

=head1 SYNOPSIS

  # YourApp.pm
  package YourApp;

  use strict;
  use base qw(App::CLI::Extension);

  # extension method
  __PACKAGE__->load_plugins(qw(Config::YAML::Syck));
  
  # extension method
  __PACKAGE__->config( config_file => "/path/to/config.yaml");
  
  1;


  # /path/to/config.yaml
  ---
  name: kurt
  age:  27

  # YourApp/Hello.pm
  package YourApp:Hello;

  use strict;
  use base qw(App::CLI::Command);

  sub run {

      my($self, @args) = @_;
      print "Hello! my name is " . $self->config->{name} . "\n";
      print "age is " . "$self->config->{age}\n";
  }

  # yourapp
  #!/usr/bin/perl

  use strict;
  use YourApp;

  YourApp->dispatch;

  # execute
  [kurt@localhost ~] youapp hello
  Hello! my name is kurt
  age is 27

=head1 DESCRIPTION

App::CLI::Extension YAML::Syck Configuration plugin module

The priority of the config file (name of the execute file in the case of [yourapp])

1. /etc/yourapp.yaml

2. /usr/local/etc/yourapp.yaml

3. $ENV{HOME}/.yourapp.yaml

4. command line option

   yourapp hello --config_file=/path/to/config.yaml

5. config method setting
   
   __PACKAGE__->config(config_file => "/path/to/config.yaml");

=cut

use strict;
use 5.8.0;
use NEXT;
use Path::Class;
use YAML::Syck;

our $VERSION = 0.01;
our @CONFIG_SEARCH_PATH = ("/etc", "/usr/local/etc", $ENV{HOME});

=pod

=head1 EXTENDED METHOD

=head2 setup

=cut

sub setup {

    my $self = shift;
    my $config_file_name = file($0)->basename . ".yaml";

    foreach my $search_path(@CONFIG_SEARCH_PATH){

        my $file = file($search_path, ($search_path eq $ENV{HOME}) ? ".$config_file_name" : $config_file_name);
        if(-e $file && -f $file){
            $self->config(LoadFile($file));
        }
    }
    
    if(exists $self->{config_file} && defined $self->{config_file}){
        $self->config(LoadFile($self->{config_file}));
    }
    
    if(exists $self->config->{config_file} && defined $self->config->{config_file}){
        $self->config(LoadFile($self->config->{config_file}));
    }

    return $self->NEXT::setup;
}

1;

__END__

=head1 SEE ALSO

L<App::CLI::Extension> L<NEXT> L<Path::Class> L<YAML::Syck>

=head1 AUTHOR

Akira Horimoto

=head1 COPYRIGHT AND LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

Copyright (C) 2008 Akira Horimoto

=cut

