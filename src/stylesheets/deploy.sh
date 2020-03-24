#!/bin/bash

#set -o errexit
me=$(basename $0)
HOME=$(pwd)

declare development_dest=/var/www/html/
declare production_dest=soccentric

now=$(date +"%m-%d-%Y")

usage() {
  cat <<eof 1>&2
  Usage: $me [-h] 
  -h:  help
  -d:  development 
  -p:  production
eof

  exit 2
}

production() {

  cp -r $HOME/* $DEST
  message="testing on $NOW"
  echo $message
}

development() {
  cp -r $HOME/* $DEST

  NOW=$(date +"%m-%d-%Y")

  message="testing on $NOW"
  echo $message

  git add .
  git commit -am $message
}

# __main__
while getopts ":hbp" opt; do
  case ${opt} in
  h)
    usage
    ;;
  \?)
    usage
    ;;
  b)
    development
    ;;
  p)
    production
    ;;
  esac
done
