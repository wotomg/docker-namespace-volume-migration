#!/usr/bin/env bash 

if [[ -n $1 && -e $1 ]]; then
  DOCKER_VOLUME=$1
else
  echo "Please, specify the volume" 
  exit 1
fi

if [[ -z $(grep ^$2 /etc/subuid) && -z $(grep ^$2 /etc/subgid) ]]; then
  echo "There is no user $2 in /etc/subuid or /etc/subgid"
  exit 1
else
  REMAP_USER=$2
fi


if [ "$EUID" -ne 0 ]; then
  read -p "You are not root! Do you want to continue? y/N?" -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1 || return 1
  fi
fi

SUB_UID=$(grep ^$REMAP_USER\: /etc/subuid | sed -e 's/:/ /g' | awk '{print $2}')
SUB_GID=$(grep ^$REMAP_USER\: /etc/subgid | sed -e 's/:/ /g' | awk '{print $2}')

find $DOCKER_VOLUME  -print0 | while read -d $'\0' file 
do
  FILE_UID=$(ls -dn "$file" | awk '{print $3}')
  FILE_GID=$(ls -dn "$file" | awk '{print $4}')

  NEW_UID=$(echo "$FILE_UID+$SUB_UID" | bc )
  NEW_GID=$(echo "$FILE_GID+$SUB_GID" | bc )

  echo "DOING: chown $NEW_UID:$NEW_GID $file" 
  chown $NEW_UID:$NEW_GID $file
done

