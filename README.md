# Debian Ansible Docker Image

Docker image for pet test in debian with ansible

## Usage

```
docker run --rm -ti --cap-add SYS_ADMIN -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v <ansible_base_dir>:/tmp/ansible -e "TEST_GROUPS=<groups>" theist/debian_ansible
```

This image will create a temporal ansible inventory called `test_inventory` and
will call `ansible-playbook` using that inventory over the docker image and
running `/tmp/ansible/site.yml` playbook.

After the ansible run the container will return the control to an interactive bash
session to allow inspect the container contents

The inventory created will have `127.0.0.1` host in `all` group and in any group
passed by the TEST_GROUPS environment variable

This image adds a systemd instance running because some ansible comands needs it to make changes star services and so. So it only works on hosts where systemd is present.
