#!/bin/bash

function execute_with_root () {
  osascript -e "do shell script \"$1\" with administrator privileges"
}

function activateService() {
  execute_with_root "networksetup -setdnsservers Wi-Fi 208.122.23.22 208.122.23.23" && \
  echo "Unblockus DNS activated."
}

function deactivateService() {
  execute_with_root "networksetup -setdnsservers Wi-Fi Empty" && \
  echo "Unblockus DNS deactivated."
}

if [ "$1" = "on" ] 
  then
    activateService
elif [ "$1" = "off" ]
  then
    deactivateService
elif [ "$1" = "status" ]
  then
    if networksetup -getdnsservers Wi-Fi | grep -q "208.122.23"; then
      echo 'Unblockus DNS is active.'
    else
      echo 'Unblockus DNS is not active.'
    fi
else 
    if networksetup -getdnsservers Wi-Fi | grep -q "There aren't any DNS Servers set"; then
      activateService
    else
      deactivateService
    fi
  fi
