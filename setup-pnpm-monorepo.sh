#!/usr/bin/env bash

CLIENT_NAME=$1
PROJECT_NAME=$2
ORG_NAME=${3:-koji-sas}

reset_git() {
  rm -rf .git
  git init
}

git clone . $CLIENT_NAME-$PROJECT_NAME
cd $_

pnpm install
pnpm cli setup $CLIENT_NAME $PROJECT_NAME $ORG_NAME

echo "Setting up Git"
reset_git
git add -A
git commit -m "chore: import template and setup monorepo"
git branch -M trunk
