#!/bin/sh

case "${GITHUB_BRANCH:-}" in
  master)
    ENV=dev
    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID_dev
    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY_dev
    ;;
  staging)
    ENV=stg
    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID_stg
    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY_stg
    ;;
  production)
    ENV=prd
    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID_prd
    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY_prd
    ;;
esac

export ENV=${ENV:-ENV_NOT_SET}
