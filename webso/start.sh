#!/usr/bin/env bash

scriptpath=$0
case $scriptpath in 
 ./* )  SCRIPT_PATH=`pwd` ;;
  * )  SCRIPT_PATH=`dirname $scriptpath`
esac

SOLR_HOME=$SCRIPT_PATH/solr
case "`uname`" in
  CYGWIN*) SOLR_HOME=`cygpath -w $SOLR_HOME`
  ;;
esac

SERVER="-server"

JVM=java
#does the jvm support -server?
$JVM -server -version > /dev/null 2>&1
if [ $? != "0" ]; then
  SERVER=""
fi

JAVA_OPTS="$SERVER $HEAPSIZE -Dsolr.solr.home=$SOLR_HOME" 
export JAVA_OPTS

echo Solr home: $SOLR_HOME
## start tomcat or jetty
if [ -d $SCRIPT_PATH/tomcat ];
##tomcat
then 
 echo "Starting Tomcat"
 tomcat/bin/catalina.sh start
else
##jetty
 echo "Starting Jetty"
 cd $SCRIPT_PATH
 export JETTY_HOME=$SCRIPT_PATH/jetty
 #java -DSTOP.PORT=8074 -DSTOP.KEY=secret -Djetty.home=jetty $JAVA_OPTS -jar jetty/start.jar jetty/etc/jetty.xml jetty/etc/jetty-logging.xmlA
#java -Xms512M -Xmx1024M -Dsolr.clustering.enabled=true -Dsolr.solr.home=/opt/solr/knomie-solr/solr-4.6.0/knomie/solr -Djetty.home=/opt/solr/knomie-solr/solr-4.6.0/knomie/ -jar /opt/solr/knomie-solr/solr-4.6.0/knomie/start.jar /opt/solr/knomie-solr/solr-4.6.0/knomie/etc/jetty.xml>> /var/log/solr_knomie.log
java -Xms512M -Xmx1024M -Dsolr.clustering.enabled=true -Dsolr.solr.home=/opt/solr/webso/webso-db/webso/solr -Djetty.home=/opt/solr/webso/webso-db/webso/ -jar /opt/solr/webso/webso-db/webso/start.jar /opt/solr/webso/webso-db/webso/etc/jetty.xml>> /var/log/solr_webso.log
fi
