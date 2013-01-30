package RRD::Rawish::Test;
use utf8;
use strict;
use warnings;

use base 'Exporter';
our @EXPORT_OK = qw(rrd_create rrd_setup);

use RRD::Rawish;

sub rrd_create {
    my ($rrd_file) = @_;
    my $rrd = RRD::Rawish->new(+{
        rrdfile => $rrd_file,
    });
    my $params = [
        "DS:rx:DERIVE:40:0:U",
        "DS:tx:DERIVE:40:0:U",
        "RRA:LAST:0.5:1:240",
    ];
    my $opts = +{
        '--start'        => '1350294000',
        '--step'         => '20',
        '--no-overwrite' => '1',
    };

    $rrd->create($params, $opts);
    $rrd;
}

sub rrd_setup {
    my ($rrd_file) = @_;

    if (-f $rrd_file) {
        unlink $rrd_file;
    }

    my $rrd = rrd_create($rrd_file);
    my $params = [
        "1350294020:0:0",
        "1350294040:50:100",
        "1350294060:80:150",
        "1350294080:100:200",
        "1350294100:180:300",
        "1350294120:220:380",
        "1350294140:270:400",
    ];
    $rrd->update($params);
    $rrd;
}

1;
__END__
