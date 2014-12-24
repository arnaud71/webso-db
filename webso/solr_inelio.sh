#!/bin/sh
#
# Startup script for solr
#
# Stop myself if running
PIDFILE=/var/run/solr.pid
HOME_SOLR=/opt/solr/webso
#
start() {
	sleep 1
	java -Xms512M -Xmx6G -Dsolr.clustering.enabled=true -Dsolr.solr.home=${HOME_SOLR}/solr -Djetty.home=${HOME_SOLR}/ -jar ${HOME_SOLR}/start.jar ${HOME_SOLR}/etc/jetty.xml >> /var/log/webso/solr.log &
	# write pidfile
	echo $! > $PIDFILE
}
#
stop() {
	[ -f ${PIDFILE} ] && kill -s SIGINT `cat ${PIDFILE}`
	# remove pidfile
	rm -f $PIDFILE
}
#
case "$1" in
	start)
		start
	;;
	stop)
		stop
	;;
	restart)
		stop
		sleep 1
		start
	;;
	*)
		echo "Usage: $0 (start|stop|restart)"
		exit 1
	;;
esac
# End 
