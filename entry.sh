#!/bin/bash

env > /etc/docker.env

echo -e "#!/bin/bash\n exec $@" > /etc/docker.cmd
chmod +x /etc/docker.cmd

echo 'ForwardToConsole=yes' >> /etc/systemd/journald.conf
echo 'MaxLevelConsole=err'	>> /etc/systemd/journald.conf

systemctl enable /etc/systemd/system/launch.service

exec /sbin/init