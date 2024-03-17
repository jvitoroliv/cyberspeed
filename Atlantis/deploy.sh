#!/bin/sh
set -euo pipefail

export AWS_REGION=us-east-1

source scripts/pipeline-env.sh

action=${1:-}
shift || :

case "$action" in
  stacks)
    ansible-playbook \
        -i /dev/null \
        deploy-atlantis.yml \
        -e 'ansible_python_interpreter=/usr/bin/python3' \
        "$@"
    ;;

  *)
    echo >&2 "Usage: deploy.sh <stacks>"
    exit 1
    ;;
esac
