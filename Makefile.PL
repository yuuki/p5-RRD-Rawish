use strict;
use warnings;

use inc::Module::Install;

name 'RRDTool-Rawish';
author 'Yuuki Tsubouchi <yuuki@cpan.org>';
all_from 'lib/RRDTool/Rawish.pm';

requires 'Capture::Tiny';
requires 'File::Which', 1.09;

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
test_requires 'Test::Fatal';
test_requires 'Test::Mock::ExternalCommand';

auto_include;
WriteAll;
