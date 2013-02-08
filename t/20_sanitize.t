use utf8;
use strict;
use warnings;
use lib lib => 't/lib';

use Test::More;
use Test::Fatal;

use RRDTool::Rawish;
use RRDTool::Rawish::Test;

my $rrdtool_path = '/usr/local/bin/rrdtool';
my $rrd_file     = './rrd_test.rrd';

subtest sanitize => sub {
    my $rrd = RRDTool::Rawish->new(
        command => $rrdtool_path,
        rrdfile => $rrd_file,
    );
    $rrd->_system("$rrdtool_path create $rrd_file --step 10; rm hoge");
    like $rrd->errstr, qr/^ERROR: can\'t parse argument/;

    $rrd->_system("$rrdtool_path create $rrd_file --step 10 && rm hoge");
    like $rrd->errstr, qr/^ERROR: can\'t parse argument/;

    $rrd->_system("$rrdtool_path create $rrd_file --step 10 || rm hoge");
    like $rrd->errstr, qr/^ERROR: can\'t parse argument/;
};

done_testing;
