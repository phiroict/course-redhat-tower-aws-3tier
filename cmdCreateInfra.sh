#!/usr/bin/env bash
source ~/.aws/set-env.sh
ansible-playbook -i local_host --ask-become-pass pb_aws_setup_security.yml
