
These are plays for purposes other than provisioning / config management - such as updates, or ad-hoc tests of the state of the network.

The command to run something against a single host looks like the following:

```sh
ansible-playbook ./update/main.yml --extra-vars "target=server.localdomain"
```

a single activiy may look like....

```yaml
---
- hosts: '{{ target }}'
  tasks:

  - name: figure my location
    shell: "hostname | awk -F '-r' '{print $NF}'"
    register: rack_num
```

groups from hosts file can be targeted:

```sh
ansible-playbook -i ../../inventory ./update/main.yml --extra-vars "target=office" --list-hosts
```
