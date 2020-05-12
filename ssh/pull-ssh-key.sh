#!/bin/sh

vaultSock=~/vault/agent.sock
user=${1}
key=${2}

if [ ! -f /usr/local/bin/vault ]; then
  echo "vault isn't installed. Install vault before running this script."
  exit
elif [ ! -f /usr/bin/jq ]; then
  echo "jq isn't installed. Install jq utility before running this script."
  exit
else
  curl -s --unix-socket ${vaultSock} http://vault/v1/ssh-keys/data/${user}/${key} > request.json
  jq -r .data.data.privkey request.json > ~/.ssh/${key}
  jq -r .data.data.pubkey request.json > ~/.ssh/${key}.pub
  cat request.json | jq
  chmod 600 ~/.ssh/${key}
  rm -f request.json
fi