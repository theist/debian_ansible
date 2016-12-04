#!/bin/bash

/lib/systemd/systemd --system &

sleep 5

if [ ! -d /ansible ]; then
  echo "ansible directory not present please run container with -v \$PDW:/tmp/ansile"
  exit 1
fi

echo "[all]" > /ansible/test_inventory
echo "127.0.0.1" >> /ansible/test_inventory
if [ "$TEST_GROUPS" ]; then
  echo "Additonal groups $TEST_GROUPS"
  for group in $TEST_GROUPS; do
    echo "[$group]" >> /ansible/test_inventory
    echo "127.0.0.1" >> /ansible/test_inventory
  done
else
  echo 'No additional groups. You can add groups via -e "TEST_GROUPS=<groups>"'
fi

cd /ansible
ansible-playbook --inventory-file=/ansible/test_inventory --list-tasks site.yml
ansible-playbook --inventory-file=/ansible/test_inventory -c local site.yml
echo ansible-playbook --inventory-file=/ansible/test_inventory -c local site.yml

/bin/bash

rm /ansible/test_inventory
