#!/bin/sh

chown -R $PUID:$PGID "${MAMCACHEDB_DB_HOME:-/var/lib/memcachedb}" || exit 2
