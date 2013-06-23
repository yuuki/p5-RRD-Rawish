# NAME

RRDTool::Rawish - A RRDtool command wrapper with rawish interface

# SYNOPSIS

    use RRDTool::Rawish;

    my $rrd = RRDTool::Rawish->new(
        rrdfile => 'rrdtest.rrd',           # option
        remote  => 'rrdtest.com:11111',  # option for rrdcached
    );
    my $exit_status = $rrd->create(["DS:rx:DERIVE:40:0:U", "DS:tx:DERIVE:40:0:U", "RRA:LAST:0.5:1:240"], {
        '--start'        => '1350294000',
        '--step'         => '20',
        '--no-overwrite' => '1',
    });

    my $exit_status = $rrd->update([
        "1350294020:0:0",
        "1350294040:50:100",
        "1350294060:80:150",
        "1350294080:100:200",
        "1350294100:180:300",
        "1350294120:220:380",
        "1350294140:270:400"
    ]);

    my $img = $rrd->graph('-', [
        "DEF:rx=rrdtest2.rrd:rx:LAST",
        "DEF:tx=rrdtest2.rrd:tx:LAST",
        "LINE1:rx:rx#00F000",
        "LINE1:tx#0000F0",
    ]);

    # error message
    $rrd->errstr; # => "ERROR: hogehoge"

# DESCRIPTION

RRDTool::Rawish is a RRDtool command wrapper class with rawish interface.
You can use the class like RRDtool command interface.
Almost all of modules with RRD prefix are RRDs module wrappers.
It's troublesome to use RRDs with variable environments because it's a XS module and moreover not a CPAN module.
In contrast, RRDTool::Rawish has less dependencies and it's easy to install it.

# METHODS

- my $rrd = RRDTool::Rawish->new(\[%args\])

    Creates a new instance of RRDTool::Rawish.

- $rrd->version()

    Returns rrdtool's version like "1.47".

- $rrd->errstr()

    Returns rrdtool's stderr string. If no error occurs, it returns empty string.

- $rrd->create($params, \[\\%opts\])
Returns exit status

    rrdtool create

- $rrd->update($params, \[\\%opts\])
Returns exit status

    rrdtool update

- $rrd->graph($filename, $params, \[\\%opts\])
Returns exit status

    rrdtool graph
    Returns image binary.

- $rrd->dump(\[\\%opts\])

    rrdtool dump
    Returns xml data.

- $rrd->restore($xmlfile, \[\\%opts\])

    rrdtool restore
    Returns exit status

- $rrd->lastupdate

    rrdtool lastupdate
    Returns timestamp

- $rrd->fetch

    rrdtool fetch
    Returns output lines as an ARRAY refarence

- $rrd->xport

    rrdtool xport
    Returns xml data

- $rrd->info

    rrdtool info
    Returns info as a HASH refarence

    Examples:

        is $value->{filename}, "rrd_test.rrd";
        is $value->{rrd_version}, "0003";
        is $value->{step}, 20;
        is $value->{last_update}, 1350294000;
        is $value->{header_size}, 904;
        is $value->{ds}->{rx}->{index}, 0;
        is $value->{ds}->{rx}->{minimal_heartbeat}, 40;
        is $value->{ds}->{rx}->{min}, "0.0000000000e+00";
        is $value->{ds}->{rx}->{max}, "NaN";
        is $value->{ds}->{rx}->{last_ds}, "U";
        is $value->{ds}->{rx}->{value},  "0.0000000000e+00";
        is $value->{ds}->{rx}->{unknown_sec}, 0;
        is $value->{ds}->{tx}->{index}, 1;
        is $value->{ds}->{tx}->{type}, "DERIVE";
        is $value->{ds}->{tx}->{minimal_heartbeat}, 40;
        is $value->{ds}->{tx}->{min}, "0.0000000000e+00";
        is $value->{ds}->{tx}->{max}, "NaN";
        is $value->{ds}->{tx}->{last_ds}, "U";
        is $value->{ds}->{tx}->{value}, "0.0000000000e+00";
        is $value->{ds}->{tx}->{unknown_sec}, 0;
        is $value->{rra}->[0]->{cf}, "LAST";
        is $value->{rra}->[0]->{rows}, 240;
        is $value->{rra}->[0]->{cur_row}, 95;
        is $value->{rra}->[0]->{pdp_per_row}, 1;
        is $value->{rra}->[0]->{xff}, "5.0000000000e-01";
        is $value->{rra}->[0]->{cdp_prep}->[0]->{value}, "NaN";
        is $value->{rra}->[0]->{cdp_prep}->[0]->{unknown_datapoints}, 0;
        is $value->{rra}->[0]->{cdp_prep}->[1]->{value}, "NaN";
        is $value->{rra}->[0]->{cdp_prep}->[1]->{unknown_datapoints}, 0;

# AUTHOR

Yuuki Tsubouchi  `<yuuki@cpan.org>`

# THANKS TO

Shoichi Masuhara

# SEE ALSO

[RRDtool Documetation](http://oss.oetiker.ch/rrdtool/)

# LICENCE AND COPYRIGHT

Copyright (c) 2013, Yuuki Tsubouchi `<yuuki@cpan.org>`. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See [perlartistic](http://search.cpan.org/perldoc?perlartistic).
