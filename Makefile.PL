use inc::Module::Install;
name 'App-CLI-Plugin-Config-YAML-Syck';
author 'Akira Horimoto';
all_from 'lib/App/CLI/Plugin/Config/YAML/Syck.pm';

build_requires 'Test::More';
requires(
      "App::CLI::Extension" => 0,
      "NEXT"                => 0,
      "YAML::Syck"          => 0,
    );
use_test_base;
auto_include_deps;
author_tests('xt');
auto_set_repository;
WriteAll;
