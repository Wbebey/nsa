#!/bin/bash

set -euxo pipefail

vm=(
    "192.168.50.50"
    "192.168.60.60"
    "192.168.70.70"
)

vagrant up \
    mysql \
    backend \
    frontend 

for ip in ${vm[@]}
do
    ssh-keygen -R $ip
    ssh -o "StrictHostKeyChecking no" vagrant@$ip 'sleep 2 &' 
done

ansible-playbook -v  playbook.yml