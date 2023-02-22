#!/bin/sh

terraform init
terraform apply -auto-approve

ansible-galaxy install -r requirements.yml

while ! ansible-playbook -v -i inventory.yml playbook.yml; do
    echo "Failed to configure server, retrying in 20 seconds"
    sleep 20
done
