#!/bin/bash

#define variables for use
clustername="elk-cluster"
nodename="elk02"
networkhost="172.19.175.131"
networkport="9200"

#append variables to file with relevant configuration settings
echo cluster.name: $clustername 								>> /etc/elasticsearch/elasticsearch.yml
echo node.name: $nodename									>> /etc/elasticsearch/elasticsearch.yml
echo node.data: true										>> /etc/elasticsearch/elasticsearch.yml
echo network.host: $networkhost									>> /etc/elasticsearch/elasticsearch.yml
echo http.port: $networkport									>> /etc/elasticsearch/elasticsearch.yml
echo discovery.zen.ping.unicast.hosts: ['"192.168.9.2"','"192.168.9.3"','"192.168.9.4"']	>> /etc/elasticsearch/elasticsearch.yml
echo discovery.zen.minimum_master_nodes: 2							>> /etc/elasticsearch/elasticsearch.yml

sudo systemctl restart elasticsearch
sudo systemctl enable elasticsearch
