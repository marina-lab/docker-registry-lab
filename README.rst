docker-registry-lab
===================

Ansible playbooks to create and provision a Docker Registry, deployed
using the docker-registry image.

The storage backend Riak CS, an S3-compatible distributed object store, is
also deployed as a container.

To tie the Registry to Riak, a dockerized Consul is deployed.

How to use
----------

Deploy to a fresh Centos 7 host and experiment. A playbook to create
a Digital Ocean Droplet is included.

Production-Readyness
--------------------

(not has)

This only configures a single node, whereas it is probably desirable to
deploy Riak CS to at least three nodes for availability and fault tolerance.

It's probably also not a good idea to expose this Registry as configured over
the internet.

TODOs:
------
 - Update to deploy to Centos 7 host (currently assumes Fedora 19 host)
 - Deploy Consul and Riak to more than one node
 - Harden security config
