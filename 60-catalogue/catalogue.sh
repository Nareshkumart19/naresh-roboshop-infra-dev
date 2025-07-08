#!/bin/bash 

component=$1
dnf install ansible -y 
ansible-pull -U https://github.com/Nareshkumart19/naresh-roles-roboshop--ansible-tf.git -e component=$1 -e env=$2 main.yaml



#component=$1
#dnf install ansible -y
#ansible-pull -U https://github.com/daws-84s/ansible-roboshop-roles-tf.git -e component=$1 -e env=$2 main.yaml

#https://github.com/Nareshkumart19/roles-roboshop-ansible.git


