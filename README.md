Docker volume migration to new namespace.
By default dockerd runs containers as root. If you have added dockerd startup --userns-remap=default option, you can have some problems with volume permissions. Same problem you might have by running rootless docker.
Then this script can help you to fix permissions.
This script execute chown on every file (and directory) in volume, then increase UID and GID by values in /etc/subuid and /etc/subgid.

How to use it:
```bash
docker-ns-migration.sh PATHTOVOLUME USERNAME
```

Example:
```bash
docker-ns-migration.sh /path/to/docker/volume dockremap
```
