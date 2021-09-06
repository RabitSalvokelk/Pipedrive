# Pipedrive

# Pipedrive# Pipes
Pipedrive

Create code for your favorite automation tool (Chef, Ansible, Bash, Terraform, CloudFormation etc.) 
to deploy ELK stack (Elasticsearch, Logstash, Kibana) and supporting services on platform of your choice 
(AWS, OpenStack, VirtualBox, QEMU, Docker, Vagrant or anything else).
Commit the code to a git repository (Github, Bitbucket, etc.) and provide a link to the repository as a solution.

Requirements:

Software versions: any supported version is okay.

Operating system: any supported version of Debian, Ubuntu, CentOS or Fedora.

If using Docker -- write your own Dockerfiles, do not use containers from Docker Hub!

All the servers can reside in the same local network.


Minimal solution: code to install and configure:

Cluster of 3 Elasticsearch nodes

1 Logstash node

Logstash listening on TCP port 5042

Logstash can write to Elasticsearch

1 Kibana node

Kibana listening on a public interface

Kibana can read from Elasticsearch

It is fine to leave some steps manual, however, you’ll get the maximum score if the process is as automated as possible.
Please include short notes in README.md of your Git repository with instructions on how to use your code and a description of manual steps if any.

Bonus task:

Automate virtual machine and/or container creation and orchestration

Can use the same or some other automation framework

Add monitoring service of your choice: Nagios, Zabbix, Grafana, NewRelic etc.

CPU usage and disk space monitoring of every server is enough for this task

Describe backup approach for all components (free text)

Use standard HTTP ports and set up a TLS for all services

Self-signed certificates are okay


Pieces of code:

Machinedeployment will deploy a new debian machine with automatic install (since vbox has two issues with unattended install manual fixes had to be made in isolinux-txt.cfg file and pointing at pre and post install scripts. See: https://www.virtualbox.org/ticket/18410 & https://www.virtualbox.org/ticket/17335)

Depending on the enviornment network setup and ssh may have to be installed and configured manually in order to send remote commands to the machines

Admincheck will check if script is being run with privileges, if it is not returns error and exits

Stackinstall will install elastic, kibana and logstash on the elkmstr... restart and enable the services.

Elkdeployment will install java and elasticsearch to elk02 and elk03 machines, have to be pushed through SSH

Elkconfiguration will push relevant changes to the machine through SSH appending to elasticsearch.yml settings that need to be applied.

