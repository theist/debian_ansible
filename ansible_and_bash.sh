#!/bin/bash

if [ ! -d /tmp/ansible ]; then
  echo "ansible directory not present please run container with -v \$PDW:/tmp/ansile"
  exit 1
fi

echo "[all]" > /tmp/ansible/test_inventory
echo "127.0.0.1" >> /tmp/ansible/test_inventory
if [ "$TEST_GROUPS" ]; then
  echo "Additonal groups $TEST_GROUPS"
  for group in $TEST_GROUPS; do
    echo "[$group]" >> /tmp/ansible/test_inventory
    echo "127.0.0.1" >> /tmp/ansible/test_inventory
  done
else
  echo 'No additional groups. You can add groups via -e "TEST_GROUPS=<groups>"'
fi

cd /tmp/ansible
ansible-playbook --inventory-file=/tmp/ansible/test_inventory --list-tasks site.yml
ansible-playbook --inventory-file=/tmp/ansible/test_inventory -c local site.yml
echo ansible-playbook --inventory-file=/tmp/ansible/test_inventory -c local site.yml

/bin/bash

rm /tmp/ansible/test_inventory
