#!/bin/bash

set -euo pipefail

docker rm gce-ci || true
docker create --name gce-ci -e STARTUP_SCRIPT_FILE=/usr/local/install/data/startup.sh openshift/origin-gce:latest $@
docker cp data gce-ci:/usr/local/install
docker start -a gce-ci

# source data/config.sh
# oc login "https://${MASTER_DNS_NAME}" # has to be through UI
# grant cluster admin to user
# oc apply -f setup/roles.yaml
# set up router certificate
# oc project ci
# oc secrets new origin-gce data -o yaml > setup/secrets.yaml
# oadm policy remove-cluster-role-from-group self-provisioner system:authenticated:oauth
# add self-provisioner to "self-provisioners" group
# oadm policy add-cluster-role-to-user cluster-reader system:serviceaccount:kube-system:heapster
# oc process -f setup/heapster-standalone.yaml | oc apply -f - -n kube-system
# change registry DNS name to registry.svc.ci.openshift.org
# set env var COCKPIT_KUBE_URL=https://registry-console-default.svc.ci.openshift.org