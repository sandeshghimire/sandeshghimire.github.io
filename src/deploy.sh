#!/bin/sh

set -o errexit

me=$(basename $0)

home=$(pwd)
src=$home/src

declare development_dest=/var/www/html/
declare production_dest=soccentric:$development_dest

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
  echo "production"
  echo $src
  echo $production_dest
  rsync -av -e ssh $src/ sandesh@$production_dest

}

development() {
  echo "development"
  scp -r $src/* $development_dest
}

# __main__
while getopts ":hdp" opt; do
  case ${opt} in
  h)
    usage
    ;;
  \?)
    usage
    ;;
  d)
    development
    ;;
  p)
    production
    ;;
  esac
done
