#!/bin/sh

agentPath=~/vault
agentConfig=agent.hcl

if [ ! -f /usr/local/bin/vault ]; then
  echo "vault isn't installed. Install vault before running this script. Aborting..."
  exit
elif [ ! -f ${agentPath}/cert.pem ]; then
  echo "cert.pem isn't present in ${agentPath}. Aborting..."
  exit
elif [ ! -f ${agentPath}/privkey.pem ]; then
  echo "privkey.pem isn't present in ${agentPath}. Aborting..."
  exit
elif [ ! -f ${agentPath}/${agentConfig} ]; then
  echo "${agentConfig} isn't present in ${agentPath}. Aborting..."
  exit
else
  cd ${agentPath}
  vault agent -config=${agentConfig}
fi