#!/bin/sh

# echo "$VAULT_PASS" > ~/.vault_pass.txt
echo "asdf" > /root/.vault_pass.txt
mkdir /root/.ssh
echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_rsa
# ansible-vault --vault-password-file ~/.vault_pass.txt view ansible/ssh_key.txt.secret > ~/.ssh/id_rsa
chmod -R 0600 /root/.ssh
export ANSIBLE_VAULT_PASSWORD_FILE=/root/.vault_pass.txt

ansible-playbook -e "build_sha=$GITHUB_SHA" -i ansible/inventories/$INVENTORY ansible/playbooks/$PLAYBOOK.yml
