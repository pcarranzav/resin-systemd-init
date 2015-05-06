#!/bin/bash

if [ "$INITSYSTEM" = "on" ]; then
	echo Systemd init system enabled:
	env > /etc/docker.env

	echo -e "#\!/bin/bash\n exec $@" > /etc/resinApp.cmd
	chmod +x /etc/resinApp.cmd

	echo 'ForwardToSyslog=no' >> /etc/systemd/journald.conf

	#udevadm trigger

	systemctl enable /etc/systemd/system/launch.service > /dev/null
	alias resin-app-logs='journalctl -u launch'

	#systemctl enable /etc/systemd/system/udev-trigger.service

	echo "Starting init..."
	exec /sbin/init --log-target=null --log-level=err
else
	CMD=$(which $1)
	shift
	echo $CMD $@
	exec "$CMD" "$@"
fi
