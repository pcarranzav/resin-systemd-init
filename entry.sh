#!/bin/bash

if [ $INITSYSTEM = "on" ]; then
	echo Systemd init system enabled:
	env > /etc/docker.env

	echo -e "#!/bin/bash\n exec $@" > /etc/resinApp.cmd
	chmod +x /etc/resinApp.cmd

	echo 'ForwardToConsole=yes' >> /etc/systemd/journald.conf

	systemctl enable /etc/systemd/system/launch.service

	exec /sbin/init
else
	CMD=$(which $1)
	shift
	echo $CMD $@
	exec /bin/bash -c $@
fi