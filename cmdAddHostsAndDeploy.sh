#!/usr/bin/env bash
source ~/.aws/set-env.sh
ansible-playbook --ask-vault-pass -i local_host pb_aws_install_apps.yml
