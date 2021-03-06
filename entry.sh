#!/bin/bash

if [ "$INITSYSTEM" = "on" ]; then
	GREEN='\033[0;32m'
	echo -e "${GREEN}Systemd init system enabled."
	env > /etc/docker.env

	echo -e "#!/bin/bash\n exec $@" > /etc/resinApp.cmd
	chmod +x /etc/resinApp.cmd

	#echo 'ForwardToConsole=yes' >> /etc/systemd/journald.conf

	#udevadm trigger

	systemctl --quiet enable /etc/systemd/system/launch.service &> /dev/null

	#systemctl enable /etc/systemd/system/udev-trigger.service
	exec /sbin/init quiet
else
	CMD=$(which $1)
	shift
	exec "$CMD" "$@"
fi
