#!/usr/bin/env groovy

library "github.com/openshift/release-library@master"

buildPipeline(
  "build",
  cloneStep("openshift-ansible:test-base"),
  [buildStep(
    /* from */ "src",
    /*  to  */ "tox",
    /*  do  */ "RUN umask 0002 && /usr/bin/tox --notest"
  ),buildStep(
    /* from */ "src",
    /*  to  */ "rpms",
    /*  do  */ "RUN umask 0002 && mkdir -p /srv/openshift-ansible/noarch && tito tag --offline --accept-auto-changelog && tito build --output=/srv/ --rpm --test --offline --quiet && createrepo /srv/openshift-ansible/noarch"
  )]
)
