Docker volume migration to new namespace.
If you have used dockerd runned by root with mounted volumes, and now you want to run it as unprivileged user, by using --userns-remap=default option. Then this script can help you to fix volume permissions.
This script execute chown on every file (and directory) in volume, then increase UID and GID by values in /etc/subuid and /etc/subgid. This script works only with default user dockremap.

How to use it:
```bash
docker-ns-migration.sh /path/to/docker/volume
```
