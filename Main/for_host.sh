#!/bin/bash

if [ "$EUID" -ne 0 ]
    then
        echo "Please run this script with sudo access"
        exit
    else
    	echo "sudo access confirmed"
    	exit 
fi

#can be run straight from elk host or pushed through SSH (ssh root@elkmstr < /path/code_for_host.sh) provided it is configured

#define variables for use
clustername="elk-cluster"
nodename="elkmstr"
networkhost="172.19.175.130"
networkport="9200"
elasticsearchhosts=$(echo "http://" $networkhost ":" $networkport | tr -d ' ')
logstashhosts=$(echo $networkhost ":" $networkport | tr -d ' ')

#install java
sudo apt-get install default-jre -y
#wget elastic
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
sudo apt-get update
#install
sudo apt-get install elasticsearch -y
#install kibana
sudo apt-get install kibana -y
#install logstash
sudo apt-get install logstash -y

#elasticsearch configuration
{
echo 'cluster.name: '$clustername''
echo 'node.name: '$nodename''
echo 'node.data: true;'
echo 'network.host: '$networkhost''
echo 'http.port: '$networkport''
echo 'discovery.zen.ping.unicast.hosts: ['"192.168.9.2"','"192.168.9.3"','"192.168.9.4"']'
echo 'discovery.zen.minimum_master_nodes: 2'
}	 >> /etc/elasticsearch/elasticsearch.yml
#kibana configuration
{
echo 'server.host: "0.0.0.0"'
echo 'elasticsearch.hosts: '$elasticsearchhosts''
}	>> /etc/kibana/kibana.yml
#logstash configuration
{
echo ' input {'
echo ' tcp {'
echo '   port => 5042'
echo '   type => syslog'
echo ' }'
echo ''
echo '}'
echo ''
echo 'filter {'
echo ' if [type] == "syslog" {'
echo '   grok {'
echo '     match => { "message" => "%{SYSLOGTIMESTAMP:syslog_timestamp} %{SYSLOGHOST:syslog_hostname} %{DATA:syslog_program}(?:\[%{POSINT:syslog_pid}\])?: %{GREEDYDATA:syslog_message}" }'
echo '     add_field => [ "received_at", "%{@timestamp}" ]'
echo '     add_field => [ "received_from", "%{host}" ]'
echo '   }'
echo '   date {'
echo '     match => [ "syslog_timestamp", "MMM  d HH:mm:ss", "MMM dd HH:mm:ss" ]'
echo '   }'
echo ' }'
echo '}'

echo 'output {'
echo ' elasticsearch { hosts => ['$logstashhosts'] }'
echo ' stdout { codec => rubydebug }'
echo '}'
} >> /etc/logstash/conf.d/logstash.conf
#restart all services and enable on boot
sudo systemctl restart logstash
sudo systemctl enable logstash
sudo systemctl restart elasticsearch
sudo systemctl enable elasticsearch
sudo systemctl restart kibana
sudo systemctl enable kibana