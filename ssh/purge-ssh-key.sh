#!/bin/sh

vaultSock=~/vault/agent.sock
secretEngine=ssh-keys
user=${1}
key=${2}

if [ ! -f /usr/local/bin/vault ]; then
  echo "vault isn't installed. Install vault before running this script. Aborting..."
  exit
elif [ ! -f /usr/bin/jq ]; then
  echo "jq isn't installed. Install jq utility before running this script. Aborting..."
  exit
else
  curl -X DELETE --unix-socket ${vaultSock} http://vault/v1/${secretEngine}/metadata/${user}/${key}
fi