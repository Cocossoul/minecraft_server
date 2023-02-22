#!/bin/sh

terraform apply -auto-approuve

ansible-galaxy install -r requirements.yml

while ! ansible-playbook -v -i inventory.yml playbook.yml; do
    echo "Failed to configure server, retrying in 10 seconds"
    sleep 10
done
