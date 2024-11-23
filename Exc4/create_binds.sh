#!/bin/bash

kubectl create clusterrolebinding secret-reader-devops-binding \
  --clusterrole=secret-reader \
  --group=devops

kubectl create clusterrolebinding secret-manager-ops-binding \
  --clusterrole=secret-manager \
  --group=ops
