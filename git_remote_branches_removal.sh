#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLACK='\033[0;30m'

GENERAL_BRANCHES_NO_DELETE="origin/($3)$"

GIT_UNDER_DIR='git --git-dir="$1"/.git --work-tree="$1"'

echo -e "${RED}"
echo -e "*WARNING* After this operation: only all the UNMERGED branches not on the blacklist, plus the following, will be preserved:"

echo -e "${GREEN}"
for branch in $(eval "$GIT_UNDER_DIR branch -r | egrep '$GENERAL_BRANCHES_NO_DELETE' | grep -v origin/HEAD"); do 
	echo $branch
done

echo -e "${BLACK}"
echo "CONTINUE? [y/n]"
read CONTINUE

UNMERGED_BRANCHES_TO_DELETE=$(<"$2")

MERGED_BRANCHES_TO_DELETE=$(eval "$GIT_UNDER_DIR branch -r --merged | egrep '$GENERAL_BRANCHES_NO_DELETE' -v")

if [ "$CONTINUE" = 'y' ]; then
	for branch in $UNMERGED_BRANCHES_TO_DELETE$MERGED_BRANCHES_TO_DELETE; do 
		#get the branch name without 'origin' in front
		BRANCH_NAME=`expr "$branch" : "origin/\(.*\)"`
		
		#escaping sepical chars
		BRANCH_NAME="${BRANCH_NAME//&/\&}"
		BRANCH_NAME="${BRANCH_NAME//\'/\'}"

		eval $GIT_UNDER_DIR' push origin --delete '$BRANCH_NAME
	done
fi