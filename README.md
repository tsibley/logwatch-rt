# A ready-out-of-the-box logwatch configuration for Request Tracker (RT)

This configuration is designed to report interesting events from your RT logs
in the normal logwatch style.  By default it expects that RT is logging to
syslog under the ident `RT`, with a level no more verbose than `info`, and that
log lines will appear in `/var/log/messages` or `/var/log/syslog`.  Usually
this means all your `RT_SiteConfig.pm` needs to contain is:

```perl
    Set($LogToSyslog, 'info');
```

It currently reports the following metrics:

* Failed login attempts by username and source
* Count of invalid ticket IDs requested
* Count of sessions purged by rt-clean-sessions
* Count of tickets created
* All unrecognized lines (lines neither ignored nor matching a known pattern)

## Installation

To use this overlay, simply run:

    sudo make install

from a git clone or other copy of the source.  If your logwatch configuration
is somewhere other than `/etc/logwatch`, pass `PREFIX=/path/to/logwatch` to
make:

    sudo make install PREFIX=/path/to/logwatch

You can test to see if it worked by running:

    sudo /usr/sbin/logwatch --service rt --print --archive --range all

and examining the output.

## Additional configuration

You may wish to ignore additional log lines by adding patterns to
`/etc/logwatch/conf/rt-ignore.conf`.

If you're using RT's `$LogToFile` option instead of `$LogToSyslog`, you can use
the included `conf/logfiles/rt.conf` by adding the following to your
`/etc/logwatch/conf/override.conf`:

    services/rt: LogFile = 
    services/rt: LogFile = rt

This will look for RT logs in `/var/log/rt.log` (the default) instead of
syslog.  You will also need to remove the following line from
`/etc/logwatch/conf/services/rt.conf`:

    *OnlyService = RT

Unfortunately, I don't know how to remove a shared script filter from
`override.conf`.
