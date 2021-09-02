#!/bin/bash
set -e

tos=tonos-cli
if test -f "$tos"; then
    echo "$tos exists."
else
    echo "$tos not found in current directory. Please, copy it here and rerun script."
    exit
fi



NAME=PiggyBank

function get_address {
echo $(cat log.log | grep "Raw address:" | cut -d ' ' -f 3)
}
function genaddr {
tonos-cli genaddr $1.tvc $1.abi.json --genkey $1.keys.json > log.log
}

LOCALNET=http://127.0.0.1
DEVNET=https://net.ton.dev
MAINNET=https://main.ton.dev
NETWORK=$DEVNET

echo _______
genaddr NAME
ADDRESS=$(get_address)

echo DEPLOY $DEBOT_ADDRESS

tonos-cli --url $NETWORK deploy NAME.tvc '{"own":["0:cdd2fdcd2b01bf154f05ba14eef99e88c7f264bb2621979e8b093df788b9298e"],"own2":["0:f08d9ad0cb548799465630c57e151847db6a5824719664f892c49a32cebff6e5"],"lim":10000000000}' --sign NAME.keys.json --abi NAME.abi.json

echo DONE
echo ADDRESS > address.log
echo debot ADDRESS
