#!/bin/bash

kubectl create clusterrole secret-reader \
  --verb=get,list \
  --resource=secrets

kubectl create clusterrole secret-manager \
  --verb=* \
  --resource=secrets
  
kubectl create clusterrole cluster-pod-reader \
--verb=get,list,watch \
--resource=pods
  
kubectl create clusterrole cluster-pod-manager \
  --verb=* \
  --resource=pods