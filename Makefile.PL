use inc::Module::Install;

name     'GoogleAPI';
all_from 'lib/GoogleAPI.pm';
author   q{Evan Carroll <me@evancarroll.com>};
license  'perl';

build_requires 'Test::More';

requires 'Moose';
requires 'MooseX::Types';
requires 'JSON';
requires 'URI';
requires 'parent';
requires 'LWP';
requires 'DateTime::Format::W3CDTF';
reqiures 'IO::Socket::SSL';

recommends 'JSON::XS';

no_index 'GoogleAPI/UserAgent.pm';

repository 'git://github.com/EvanCarroll/GoogleAPI.git';
homepage   'http://www.evancarroll.com';

auto_install;

WriteAll;

