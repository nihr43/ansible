
these are playbooks for purposes other than config management such as tests, updates, reboots...


command to run these will look like

ansible-playbook user.yml --extra-vars "target=imac-2.local"



a single activiy may look like....

---
- hosts: '{{ target }}'
  stuff:





groups from hosts file can be targeted, and no target is safe

ansible-playbook user.yml --extra-vars "target=office" --list-hosts
