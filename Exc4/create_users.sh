#!/bin/bash

create_user() {
  openssl genrsa -out $1.key 2048
  
  openssl req -new \
      -key $1.key -out $1.csr \
	  -subj "/CN=$1/O=$2"
	  
  openssl x509 -req \
      -in $1.csr \
	  -CA ~/.minikube/ca.crt \
	  -CAkey ~/.minikube/ca.key \
	  -CAcreateserial \
	  -out $1.crt \
	  -days 500
	  
  kubectl config set-credentials $1 \
    --client-certificate=$1.crt \
    --client-key=$1.key
	
  kubectl config set-context $1-context \
    --cluster=minikube \
    --user=$1
}

create_user "dev_user" "devops"

create_user "ops_user" "ops"
