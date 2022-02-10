#!/bin/bash
#
# This script will use kubectl to copy the ETL backup directory to a temporary 
# location, then tar the contents and remove the tmp directory.
# 

# Accept Optional Namespace -- default to kubecost
namespace=$1
if [ "$namespace" == "" ]; then
  namespace=kubecost
fi

# Accept Optional ETL Store Directory -- default to /var/configs/db/etl
etlDir=$2
if [ "$etlDir" == "" ]; then
  etlDir=/var/configs/db/etl
fi

# Accept etl .tar file to upload
etlFile=$3
if [ "$etlFile" == "" ]; then
  etlDir=/var/configs/db/etl
fi

# Grab the Current Context for Prompt
currentContext=`kubectl config current-context`

echo "This script will delete the Kubecost ETL storage and replace it with ETL files from the current directory using the following:"
echo "  Kubectl Context: $currentContext"
echo "  Namespace: $namespace"
echo "  ETL Directory: $etlDir"
echo -n "Would you like to continue [Y/n]? "
read r

if [ "$r" == "${r#[Y]}" ]; then
  echo "Exiting..."
  exit 0
fi


# Grab the Pod Name of the cost-analyzer pod
podName=`kubectl get pods -n $namespace -l app=cost-analyzer -o jsonpath='{.items[0].metadata.name}'`

# Copy the Files to tmp directory
echo "Copying ETL Files from $namespace/$podName:$etlDir to $tmpDir..."
kubectl cp -c cost-model ./kubecost-etl.tar.gz $namespace/$podName:/var/configs/kubecost-etl.tar.gz

# TODO: exec into the pod and replace the ETL
