# Debian Ansible Docker Image

Packer image for pet test in debian with ansible

## Usage

```
docker run --rm -ti theist/debian_ansible -v <ansible_base_dir>:/tmp/ansible -e "TEST_GROUPS=<groups>"
```

This image will create a temporal ansible inventory called `test_inventory` and
will call `ansible-playbook` using that inventory over the docker image and
running `/tmp/ansible/site.yml` playbook.

After the ansible run the container will return the control to an interactive bash
session to allow inspect the container contents

The inventory created will have `127.0.0.1` host in `all` group and in any group
passed by the TEST_GROUPS environment variable
