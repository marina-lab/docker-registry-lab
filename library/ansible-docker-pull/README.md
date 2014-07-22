Ansible Docker Pull Module
==========================

This is an Ansible module that's all about pulling docker containers!

## Usage

Copy the module as directed by the [Ansible documentation][global-docs]:

> Modules [...] are found in the path specified by ANSIBLE_LIBRARY or
> the --module-path command line option.

You can also add it to a [playbook-specific directory][playbook-docs]:

> If a playbook has a ”./library” directory relative to its YAML file,
> this directory can be used to add ansible modules

In your playbook, use it like:

```yaml
- name: get the image
  docker_pull:
    repo: busybox
    tag: latest
```

[global-docs]: http://docs.ansible.com/developing_modules.html
[playbook-docs]: http://docs.ansible.com/playbooks_best_practices.html#bundling-ansible-modules-with-playbooks
