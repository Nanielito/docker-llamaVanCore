#!/bin/bash

OPTS=`getopt -o hr:b:t: --long help,repository:,branch:,tag: -n 'parse-options' -- "$@"`
eval set -- "$OPTS"

function usage() {
  printf "Usage: $0 -r|--repository REPOSITORY [-b|--branch BRANCH] [-t|--tag TAG]"
}

REPOSITORY=""
BRANCH=""
TAG=""

while true
  do
    case "$1" in
      -h | --help)
        usage; exit 0 ;;
      -r | --repository)
        REPOSITORY=$2; shift 2 ;;
      -b | --branch)
        BRANCH=$2; shift 2 ;;
      -t | --tag)
        TAG=$2; shift 2 ;;
      --)
        shift; break ;;
      *)
        usage; exit 1 ;;
    esac
  done

if [ -z "$REPOSITORY" ]; then
  usage
  exit 1
fi

if [ -z "$BRANCH" ]; then
  BRANCH="master"
fi

if [ -z "$TAG" ]; then
  TAG="latest"
fi

echo "Cloning $REPOSITORY on branch $BRANCH..."
git clone -b $BRANCH $REPOSITORY ./llamaVanCore

docker build -t llamaVan/llamaVanCore:$TAG .

rm -rf llamaVanCore
