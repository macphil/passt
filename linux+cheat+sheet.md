# linux cheat sheet

## some commands
The following commands are in no order or context. They are more a collection of terms that you can then search for.

*show running services managed by `systemctl`*
```bash
$ sudo systemctl --type=service --state=running
```
*grep in gzip*
```bash
zgrep 'foo' access_log.202308* | more
```
