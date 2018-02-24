#!/usr/bin/env bash
source ~/.aws/set-env.sh
ansible-playbook -i local_host --ask-become-pass  pb_test_delete.yml
