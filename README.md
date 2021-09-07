# Pipedrive
Enviornment:  
OS:  
Distributor ID:	Debian  
Description:	Debian GNU/Linux 11 (bullseye)  
Release:		11  
Codename:		bullseye  
Prerequisites:  
3 hosts of the above enviornment  
VirtualBox  
Network settings configured  
ufw configured to allow ssh  
openssh configured  
Possibly a different enviornment   
A lot of time  
  
Main code:  
code_for_host.sh 	- should be run on elk host stack to install and configure elastic, kibana and logstash based on original_task.txt  
code_for_client.sh 	- should be run on elk client/node, variables adjusted per client/node to install and configure elasticsearch based on original_task.txt  
  
vm_deployment.sh	- creates and installs a new debian machine with unattended install (due to vbox having two issues with unattended install manual fixes had to be made in isolinux-txt.cfg file and pointing at pre and post install scripts. See: https://www.virtualbox.org/ticket/18410 & https://www.virtualbox.org/ticket/17335)  
monitoring.txt		- steps to manually install and configure Nagios on prebuilt enviornment on the elk nodes where elkmaster would be host and elk02,elk03 clients
tls_deployment.sh	- Installs and enables TLS for apache, could be sent over ssh or run locally  

Pieces of code:  
These are broken down to seperate files to make testing and troubleshooting easier for the time being  

Admincheck will check if script is being run with privileges, if it is not returns error and exits   
Stackinstall will install elastic, kibana and logstash on the elkmstr... restart and enable the services.    
Elkdeployment will install java and elasticsearch to elk02 and elk03 machines, have to be pushed through SSH  
Elkconfiguration will push relevant changes to the machine through SSH appending to elasticsearch.yml settings that need to be applied.  

Machinedeployment will deploy a new debian machine with automatic install (since vbox has two issues with unattended install manual fixes had to be made in isolinux-txt.cfg file and pointing at pre and post install scripts. See: https://www.virtualbox.org/ticket/18410 & https://www.virtualbox.org/ticket/17335)      
Depending on the enviornment network setup and ssh may have to be installed and configured manually in order to send remote commands to the machines  
Nagios.txt has the steps to install and configure monitoring via Nagios on elkmstr as host and elk02, elk03 as clients  
TLS_deployment.sh script to install and enable TLS for apache2, can be done locally or sent over ssh

