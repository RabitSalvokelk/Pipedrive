#!/bin/bash

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
#restart all services and enable on boot
sudo systemctl restart logstash
sudo systemctl enable logstash
sudo systemctl restart elasticsearch
sudo systemctl enable elasticsearch
sudo systemctl restart kibana
sudo systemctl enable kibana
