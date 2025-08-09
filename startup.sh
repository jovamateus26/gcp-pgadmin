#!/bin/sh
gcsfuse --gid 5050 --uid 5050 pgadmin-j /var/lib/pgadmin
exec /entrypoint.sh
