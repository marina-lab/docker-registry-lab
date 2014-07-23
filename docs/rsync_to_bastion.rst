Setting up a bastion
====================

.. code::

   ansible-playbook -i localhost create_bastion_droplet.yml -vvvv

   ansible-playbook -i bastion_hosts provision_bastion.yml -vvvv \
       -e is_first_run=true

Rsync this repository to bastion
================================

You don't want to have to commit to try your changes out from the bastion.

.. code::

   rsync -avz \
       -e "ssh" \
       --quiet \
       ../docker-registry-lab \
       107.170.5.28:~/docker-registry-lab
