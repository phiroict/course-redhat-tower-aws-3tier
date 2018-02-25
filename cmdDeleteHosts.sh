#!/usr/bin/env bash
source ~/.aws/set-env.sh

ansible-playbook --ask-become-pass -i local_host pb_aws_delete_instances.yml
