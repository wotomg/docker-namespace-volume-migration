Docker volume migration to new namespace.
By default dockerd runs containers as root. If you have added dockerd startup --userns-remap=default option, you can have some problems with volume permissions. Then this script can help you to fix permissions.
This script execute chown on every file (and directory) in volume, then increase UID and GID by values in /etc/subuid and /etc/subgid. This script works only with default user dockremap.

How to use it:
```bash
docker-ns-migration.sh /path/to/docker/volume
```
