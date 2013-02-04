use strict;
use warnings;

use inc::Module::Install;

name 'RRD::Rawish';
author 'Yuuki Tsubouchi <yuuki@cpan.org>';
all_from 'lib/RRD/Rawish.pm';

requires 'Capture::Tiny';
requires 'File::Which', 1.09;

tests 't/*.t';
test_requires 'Test::More';
test_requires 'Test::Fatal';
test_requires 'Test::Mock::ExternalCommand';

auto_set_repository;
auto_include;
WriteAll;
