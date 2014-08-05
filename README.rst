===================
docker-registry-lab
===================

Ansible playbooks to create and provision a Docker Registry, deployed
using the docker-registry image.

To tie services together via service discovery, a dockerized Consul is
deployed.

Nginx fronts the Registry, proxying requests using Consul as a DNS resolver.

A separate playbook is included to launch a new instance (droplet)
on Digital Ocean (DO) with Centos 7.

How to use
==========

Environment variables and other assumptions
-------------------------------------------

All assumptions about the control machine and the desired target configuration
that can be changed, such as hostnames and domains, are in vars.yml.

On the control machine, the `USER` environment variable will be used as the
default admin user. The ssh public key to be used with DO and deployed to the
target is assumed to be in ~/.ssh/id_rsa.pub.

Additionally, if the included playbook to launch a new droplet is used, the
following environment variables are needed to authenticate with Digital Ocean:

.. code::

   DIGITALOCEAN_API_KEY
   DIGITALOCEAN_CLIENT_ID

**All vars in vars.yml of these are overridable** with `-e` options to
`ansible-playbook`.  For convenience, you may want to create a vars.json file
and load it with `-e "@vars.json"`.

Deploy
------

Deploy to a fresh Centos 7 host and experiment. A playbook to create
a fresh Centos 7 host Digital Ocean droplet is included.

Create droplet
..............

.. code::

   ansible-playbook -i localhost create_registry_droplet.yml

Provision
.........

You must explicitly pass `is_first_run=true` on the first run.
This will ssh in as root, create the admin user, and reboot the machine
after provisioning.

.. code::

   ansible-playbook -i docker_registry_hosts provision.yml \
       -e is_first_run=true

On subsequent runs, the admin user will be used for ssh. Root login over ssh
is disabled in the first run.

.. code::

   ansible-playbook -i docker_registry_hosts provision.yml

Use
...

Tag images and push to the configured `docker_registry_server_name`, on port
80. It's recommended you create A records matching the server name on your own
domain that point to this host, but for testing, editing /etc/hosts works
just as well.

The Consul UI is also accessible via `consul_ui_server_name`, on port 80. This
is protected by basic auth, and on the first run, a file will be created with
the password at ~/credentials/docker-registry/admin_htpasswd'.

Production-Readyness
====================

(not has)

It's probably also not a good idea to expose this Registry as configured over
the internet.

We are working on both of these.

TODOs:
======
 - Harden security config
