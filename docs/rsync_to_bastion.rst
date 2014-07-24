Setting up a bastion
====================

.. code::

   ansible-playbook -i localhost create_bastion_droplet.yml -vvvv

   ansible-playbook -i bastion_hosts provision_bastion.yml -vvvv \
       -e is_first_run=true

Rsync this repository to bastion
================================

You don't want to have to commit to try your changes out from the bastion.
There's a script included to sync your changes to the bastion using
rsync and watchdog.

.. code::

   pip install watchdog

   BASTION_DEST="bastion.example.com:~/docker-registry-lab"
   ./sync-bastion.sh $BASTION_DEST
