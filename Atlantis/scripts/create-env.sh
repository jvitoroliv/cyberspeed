#!/bin/bash

# check if env variable was passed
if [ $# -eq 0 ]
  then
    echo "Usage: Please pass the environment variable <dev, stg, prd>"
    return;
fi

# check that environment matches aws account
echo "Fetching current AWS Account"
export AWS_ACCOUNT=$(aws sts get-caller-identity --output text | cut -f1)  

case "$AWS_ACCOUNT" in
  851725424717)
    if [ "$1" != "dev" ]
      then
        echo "AWS credentials don't match environment"
        return;
    fi
    ;;
  851725424717)
    if [ "$1" != "stg" ]
      then
        echo "AWS credentials don't match environment"
        return;
    fi
    ;;
  851725424717)
    if [ "$1" != "prd" ]
      then
        echo "AWS credentials don't match environment"
        return;
    fi
    ;;
    *)
      echo "No valid AWS credentials"
      return;
    ;;
esac

export AWS_REGION=us-east-1
export ENV=$1
export LOG_LEVEL=info

echo "INFO: Setting Region to $AWS_REGION, environment to $ENV and Log Level to $LOG_LEVEL"

# echo "INFO: Creating custom env for DB Access"

# export DATABASE_HOST=localhost
# export DATABASE_READ_HOST=localhost
# export DATABASE_PORT=3306
# export DATABASE_USERNAME=root
# export DATABASE_ROOT_PASSWORD=$(aws ssm get-parameter --name /pyypl/service/transactions/database/rootpassword --with-decryption --query Parameter.Value --output text)

echo "INFO: Successfully created env"
