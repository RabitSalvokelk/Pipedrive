#!/bin/bash

#define variables for use
clustername="elk-cluster"
nodename="elkmstr"
networkhost="172.19.175.130"
networkport="9200"
elasticsearchhosts=$(echo "http://" $networkhost ":" $networkport | tr -d ' ')

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
echo cluster.name: $clustername 								>> /etc/elasticsearch/elasticsearch.yml
echo node.name: $nodename									>> /etc/elasticsearch/elasticsearch.yml
echo node.data: true										>> /etc/elasticsearch/elasticsearch.yml
echo network.host: $networkhost									>> /etc/elasticsearch/elasticsearch.yml
echo http.port: $networkport									>> /etc/elasticsearch/elasticsearch.yml
echo discovery.zen.ping.unicast.hosts: ['"192.168.9.2"','"192.168.9.3"','"192.168.9.4"']	>> /etc/elasticsearch/elasticsearch.yml
echo discovery.zen.minimum_master_nodes: 2							>> /etc/elasticsearch/elasticsearch.yml
#kibana configuration
echo server.host: "0.0.0.0" 									>> /etc/kibana/kibana.yml
echo elasticsearch.hosts: $elasticsearchhosts							>> /etc/kibana/kibana.yml
#logstash configuration

#restart all services and enable on boot
sudo systemctl restart logstash
sudo systemctl enable logstash
sudo systemctl restart elasticsearch
sudo systemctl enable elasticsearch
sudo systemctl restart kibana
sudo systemctl enable kibana
