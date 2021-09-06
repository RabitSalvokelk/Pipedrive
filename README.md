# Pipedrive
Enviornment:  
OS  
Distributor ID:	Debian  
Description:	Debian GNU/Linux 11 (bullseye)  
Release:		11  
Codename:		bullseye  




Pieces of code:  
Admincheck will check if script is being run with privileges, if it is not returns error and exits  
Machinedeployment will deploy a new debian machine with automatic install (since vbox has two issues with unattended install manual fixes had to be made in isolinux-txt.cfg file and pointing at pre and post install scripts. See: https://www.virtualbox.org/ticket/18410 & https://www.virtualbox.org/ticket/17335)    
Depending on the enviornment network setup and ssh may have to be installed and configured manually in order to send remote commands to the machines  
Stackinstall will install elastic, kibana and logstash on the elkmstr... restart and enable the services.    
Elkdeployment will install java and elasticsearch to elk02 and elk03 machines, have to be pushed through SSH  
Elkconfiguration will push relevant changes to the machine through SSH appending to elasticsearch.yml settings that need to be applied.  

