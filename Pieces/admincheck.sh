#!/bin/bash

if [ $EUID -ne 0 ]
    then
        echo "Please run this script with sudo access"
        exit
    else
    	echo "sudo access confirmed"
    	exit 
fi
