#!/bin/bash
set -e
if [ "$1" = 'rinetd' ]; then
	echo $SRC $SRCPORT $DEST $DESTPORT > /etc/rinetd.conf
	/usr/sbin/rinetd -f -c /etc/rinetd.conf
fi
exec "$@"
