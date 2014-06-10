ANSIBLE_HOST_KEY_CHECKING=False \
    DROPLET_NAME=my-droplet-name \
    ansible-playbook -i localhost newdroplet.yml -vvvv
