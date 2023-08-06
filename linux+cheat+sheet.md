# linux cheat sheet

## some commands
The following commands are in no order or context. They are more a collection of terms that you can then search for.

*show running services managed by `systemctl`*
```bash
$ sudo systemctl --type=service --state=running
UNIT                      LOAD   ACTIVE SUB     DESCRIPTION
avahi-daemon.service      loaded active running Avahi mDNS/DNS-SD Stack
bluetooth.service         loaded active running Bluetooth service
cron.service              loaded active running Regular background program processing daemon
dbus.service              loaded active running D-Bus System Message Bus
dhcpcd.service            loaded active running dhcpcd on all interfaces
exim4.service             loaded active running LSB: exim Mail Transport Agent
fail2ban.service          loaded active running Fail2Ban Service
getty@tty1.service        loaded active running Getty on tty1
hciuart.service           loaded active running Configure Bluetooth Modems connected by UART
lighttpd.service          loaded active running Lighttpd Daemon
php8.0-fpm.service        loaded active running The PHP 8.0 FastCGI Process Manager
rsyslog.service           loaded active running System Logging Service
ssh.service               loaded active running OpenBSD Secure Shell server
systemd-journald.service  loaded active running Journal Service
systemd-logind.service    loaded active running User Login Management
systemd-timesyncd.service loaded active running Network Time Synchronization
systemd-udevd.service     loaded active running Rule-based Manager for Device Events and Files
triggerhappy.service      loaded active running triggerhappy global hotkey daemon
user@1000.service         loaded active running User Manager for UID 1000
wpa_supplicant.service    loaded active running WPA supplicant
```
