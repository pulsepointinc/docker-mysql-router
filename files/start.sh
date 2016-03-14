#!/bin/sh

## Write out config file
cat > /var/tmp/mysql-router.ini << EOF
[DEFAULT]
logging_folder=${LOGGING_FOLDER:-}

[logger]
level=${LEVEL:-DEBUG}

[routing:failover]
bind_address=${BIND_ADDRESS:-0.0.0.0}
bind_port=${BIND_PORT:-7001}
connect_timeout=${CONNECT_TIMEOUT:-1}
destinations = ${DESTINATIONS:-127.0.0.1:3306}
mode=${MODE:-read-write}
max_connections=${MAX_CONNECTIONS:-512}
EOF

## Log config and env for troubleshooting
cat 1>&2 << EOF
/var/tmp/mysql-router.ini:
$(cat /var/tmp/mysql-router.ini)

env:
$(env)
EOF

exec /usr/sbin/mysqlrouter --config=/var/tmp/mysql-router.ini
