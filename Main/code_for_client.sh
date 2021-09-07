#!/bin/bash

#can be run straight from elk clinet or pushed through SSH(ssh root@elk02/elk03 < /path/code_for_client.sh) provided it is configured

#define variables for use
clustername="elk-cluster"
nodename="elk02" 				#or elk03 for the other machine
networkhost="172.19.175.131" 	#or 172.19.175.132 for other machine
networkport="9200"


#install java
sudo apt-get install default-jre -y
#wget elastic
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
sudo apt-get update
#install
sudo apt-get install elasticsearch -y

#append variables to file with relevant configuration settings
{
echo 'cluster.name: '$clustername''								
echo 'node.name: '$nodename''							
echo 'node.data: true'								
echo 'network.host: '$networkhost''									
echo 'http.port: '$networkport''								
echo 'discovery.zen.ping.unicast.hosts: ['"192.168.9.2"','"192.168.9.3"','"192.168.9.4"']'	
echo 'discovery.zen.minimum_master_nodes: 2'			
}	 >> /etc/elasticsearch/elasticsearch.yml
sudo systemctl restart elasticsearch
sudo systemctl enable elasticsearch

