#!/bin/sh

vaultSock=~/vault/agent.sock
user=${1}
key=${2}

if [ ! -f /usr/local/bin/vault ]; then
  echo "vault isn't installed. Install vault before running this script. Aborting..."
  exit
elif [ ! -f /usr/bin/jq ]; then
  echo "jq isn't installed. Install jq utility before running this script. Aborting..."
  exit
elif [ ! -f ~/.ssh/${key} ]; then
  echo "Private key ${key} not found in your .ssh folder. Aborting..."
  exit
elif [ ! -f ~/.ssh/${key}.pub ]; then
  echo "Public key ${key}.pub not found in your .ssh folder. Aborting..."
  exit
else
  jq -n --arg privkey "`cat ~/.ssh/${key}`" --arg pubkey "`cat ~/.ssh/${key}.pub`" '{"data":{"privkey":$privkey,"pubkey":$pubkey}}' > request.json
  curl -s -X POST --unix-socket ${vaultSock} --data @request.json http://vault/v1/ssh-keys/data/${user}/${key} | jq
  rm -f request.json
fi