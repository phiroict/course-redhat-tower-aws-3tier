#!/usr/bin/env bash
source ~/.aws/set-env.sh
ansible-playbook --ask-vault-pass -vvvv -i aws_jump_host pb_aws_install_apps.yml
