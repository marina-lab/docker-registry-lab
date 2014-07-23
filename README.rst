===================
docker-registry-lab
===================

Ansible playbooks to create and provision a Docker Registry, deployed
using the docker-registry image.

The storage backend Riak CS, an S3-compatible distributed object store, is
also deployed as a container.

To tie the Registry to Riak, a dockerized Consul is deployed.

Nginx fronts the Registry, proxying requests using Consul as a DNS resolver.

A separate playbook is included to launch a new instance (droplet)
on Digital Ocean (DO) with Centos 7.

How to use
==========

Use the Forks, Luke
-------------------

Mainline Ansible does not have support for tagged Docker images yet, so you
will need to run a fork that includes the PR in #7739, such as sprin/ansible:

.. code::

   git clone https://github.com/sprin/ansible
   cd ./ansible
   source ./hacking/env-setup
   sudo pip install paramiko PyYAML jinja2 httplib2 dopy

You may need the following system libraries:

.. code::

    sudo yum install gcc python-devel

Note that this also uses a fork of dotcloud/docker-registry, in order to
enable connection to a Riak CS backend (#461). The fork is at
sprin/docker-registry, and the image used by this playbook is in the public
Docker registry under the same name.

Environment variables and other assumptions
-------------------------------------------

All assumptions about the control machine and the desired target configuration
that can be changed are in vars.yml.

On the control machine, the `USER` environment variable will be used as the
default admin user. The ssh public key to be used with DO and deployed to the
target is assumed to be in ~/.ssh/id_rsa.pub.

Additionally, if the included playbook to launch a new droplet is used, the
following environment variables are needed to authenticate with Digital Ocean:

.. code::

   DIGITALOCEAN_API_KEY
   DIGITALOCEAN_CLIENT_ID

All of these are overridable with `-e` options to `ansible-playbook`.
For convenience, you may want to create a vars.json file and load it with
`-e "@vars.json"`.

Deploy
------

Deploy to a fresh Centos 7 host and experiment. A playbook to create
a fresh Centos 7 host Digital Ocean droplet is included.

Create droplet
..............

.. code::

   ansible-playbook -i localhost create_registry_droplet.yml \
       -e droplet_name=docker-registry

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

This only configures a single node, whereas it is probably desirable to
deploy Riak CS to at least three nodes for availability and fault tolerance.

It's probably also not a good idea to expose this Registry as configured over
the internet.

We are working on both of these.

TODOs:
======
 - Deploy Consul and Riak to more than one node
 - Harden security config
