#!/usr/bin/env bash

PROJECT_NAME=$1
ORG_NAME=${2:koji-sas}

reset_git() {
  rm -rf .git
  git init
}

git clone git@github.com:KOJI-SAS/koji-typescript-monorepo.git $PROJECT_NAME
cd $_

sh ./scripts/setup-github.sh

while ! LC_ALL=C find ./ -type d -exec rename ''s/project-name/$PROJECT_NAME/'' {} ";" 2>/dev/null
do
  echo "Renaming directories"
done
echo "Renaming files"
LC_ALL=C find ./ -type f -exec rename ''s/project-name/$PROJECT_NAME/'' {} ";" 

echo "Replacing in files files"
LC_ALL=C find ./ -type f -exec sed -i '' -e ''s/project-name/$PROJECT_NAME/g'' {} \;
LC_ALL=C find ./ -type f -exec sed -i '' -e ''s/org-name/$ORG_NAME/g'' {} \;

echo "Setting up Git"
reset_git
git add -A
git commit -m "chore: import template and setup monorepo"
git branch -M trunk

