#!/bin/sh
#
# Automatically add branch name and branch description to every commit message except merge commit.
#

COMMIT_EDITMSG=$1

addBranchName() {
  NAME=$(git branch | grep '*' | sed 's/* //')
  DESCRIPTION=$(git config branch."$NAME".description)
  COMMIT_OLD=$(cat $COMMIT_EDITMSG)
  echo "$COMMIT_OLD" | sed -e 's/\[.*\]\: //g' > $COMMIT_EDITMSG

  echo "[fasterize/$NAME]: $(cat $COMMIT_EDITMSG)" > $COMMIT_EDITMSG

}

MERGE=$(cat $COMMIT_EDITMSG|grep -i 'merge'|wc -l)

if [ $MERGE -eq 0 ] ; then
  addBranchName
fi
