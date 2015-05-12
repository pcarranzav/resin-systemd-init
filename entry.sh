#!/bin/bash

if [ "$INITSYSTEM" = "on" ]; then
	tty
	GREEN='\033[0;32m'
	echo -e "${GREEN}Systemd init system enabled."
	env > /etc/docker.env

	echo -e "#!/bin/bash\n exec $@" > /etc/resinApp.cmd
	chmod +x /etc/resinApp.cmd

	systemctl --quiet enable /etc/systemd/system/launch.service &> /dev/null

	echo Hi > /dev/console
	mount -t devtmpfs none /dev
	echo Bye > /dev/console

	exec /sbin/init quiet
else
	CMD=$(which $1)
	shift
	exec "$CMD" "$@"
fi
