#!/usr/bin/env bash

set -e
set -u

ATLAS_DB_HOST=${ATLAS_DB_PORT_5432_TCP_ADDR:-atlas-read.service.consul}
ATLAS_DB_PORT=${ATLAS_DB_PORT_5432_TCP_PORT:-5432}
ATLAS_DB_USER=${ATLAS_DB_USER:-${ATLAS_DB_NAME}}

NAP_DB_HOST=${NAP_DB_PORT_5432_TCP_ADDR:-nap-read.service.consul}
NAP_DB_PORT=${NAP_DB_PORT_5432_TCP_PORT:-5432}
NAP_DB_USER=${NAP_DB_USER:-${NAP_DB_NAME}}

MILIEUTHEMAS_DB_HOST=${MILIEUTHEMAS_DB_PORT_5432_TCP_ADDR:-milieuthemas-read.service.consul}
MILIEUTHEMAS_DB_PORT=${MILIEUTHEMAS_DB_PORT_5432_TCP_PORT:-5432}
MILIEUTHEMAS_DB_USER=${MILIEUTHEMAS_DB_USER:-${MILIEUTHEMAS_DB_NAME}}

PANORAMA_DB_HOST=${PANORAMA_DB_PORT_5432_TCP_ADDR:-panorama-read.service.consul}
PANORAMA_DB_PORT=${PANORAMA_DB_PORT_5432_TCP_PORT:-5432}
PANORAMA_DB_USER=${PANORAMA_DB_USER:-${PANORAMA_DB_NAME}}

PARKEERVAKKEN_DB_HOST=${PARKEERVAKKEN_DB_PORT_5432_TCP_ADDR:-parkeervakken-read.service.consul}
PARKEERVAKKEN_DB_PORT=${PARKEERVAKKEN_DB_PORT_5432_TCP_PORT:-5432}
PARKEERVAKKEN_DB_USER=${PARKEERVAKKEN_DB_USER:-${PARKEERVAKKEN_DB_NAME}}

PREDICTIVEPARKING_DB_HOST=${PREDICTIVEPARKING_DB_PORT_5432_TCP_ADDR:-predictiveparking-read.service.consul}
PREDICTIVEPARKING_DB_PORT=${PREDICTIVEPARKING_DB_PORT_5432_TCP_PORT:-5432}
PREDICTIVEPARKING_DB_USER=${PREDICTIVEPARKING_DB_USER:-${PREDICTIVEPARKING_DB_NAME}}

BASISKAART_DB_HOST=${BASISKAART_DB_PORT_5432_TCP_ADDR:-basiskaart-read.service.consul}
BASISKAART_DB_PORT=${BASISKAART_DB_PORT_5432_TCP_PORT:-5432}
BASISKAART_DB_USER=${BASISKAART_DB_USER:-${BASISKAART_DB_NAME}}

HANDELSREGISTER_DB_HOST=${HANDELSREGISTER_DB_PORT_5432_TCP_ADDR:-handelsregister-read.service.consul}
HANDELSREGISTER_DB_PORT=${HANDELSREGISTER_DB_PORT_5432_TCP_PORT:-5432}
HANDELSREGISTER_DB_USER=${HANDELSREGISTER_DB_USER:-${HANDELSREGISTER_DB_NAME}}

TELLUS_DB_HOST=${TELLUS_DB_PORT_5432_TCP_ADDR:-tellus-read.service.consul}
TELLUS_DB_PORT=${TELLUS_DB_PORT_5432_TCP_PORT:-5432}
TELLUS_DB_USER=${TELLUS_DB_USER:-${TELLUS_DB_NAME}}

echo Creating configuration files

cat > /srv/mapserver/connection.inc <<EOF
CONNECTIONTYPE postgis
CONNECTION "host=${ATLAS_DB_HOST} dbname=${ATLAS_DB_NAME} user=${ATLAS_DB_USER} password=${ATLAS_DB_PASSWORD} port=${ATLAS_DB_PORT}"
EOF

cat > /srv/mapserver/connection_nap.inc <<EOF
CONNECTIONTYPE postgis
CONNECTION "host=${NAP_DB_HOST} dbname=${NAP_DB_NAME} user=${NAP_DB_USER} password=${NAP_DB_PASSWORD} port=${NAP_DB_PORT}"
EOF

cat > /srv/mapserver/connection_milieu.inc <<EOF
CONNECTIONTYPE postgis
CONNECTION "host=${MILIEUTHEMAS_DB_HOST} dbname=${MILIEUTHEMAS_DB_NAME} user=${MILIEUTHEMAS_DB_USER} password=${MILIEUTHEMAS_DB_PASSWORD} port=${MILIEUTHEMAS_DB_PORT}"
EOF

cat > /srv/mapserver/connection_panorama.inc <<EOF
CONNECTIONTYPE postgis
CONNECTION "host=${PANORAMA_DB_PORT_5432_TCP_ADDR} dbname=${PANORAMA_DB_NAME} user=${PANORAMA_DB_USER} password=${PANORAMA_DB_PASSWORD} port=${PANORAMA_DB_PORT_5432_TCP_PORT}"
EOF

cat > /srv/mapserver/connection_parkeervakken.inc <<EOF
CONNECTIONTYPE postgis
CONNECTION "host=${PARKEERVAKKEN_DB_HOST} dbname=${PARKEERVAKKEN_DB_NAME} user=${PARKEERVAKKEN_DB_USER} password=${PARKEERVAKKEN_DB_PASSWORD} port=${PARKEERVAKKEN_DB_PORT}"
EOF

cat > /srv/mapserver/connection_predictiveparking.inc <<EOF
CONNECTIONTYPE postgis
CONNECTION "host=${PREDICTIVEPARKING_DB_HOST} dbname=${PREDICTIVEPARKING_DB_NAME} user=${PREDICTIVEPARKING_DB_USER} password=${PREDICTIVEPARKING_DB_PASSWORD} port=${PREDICTIVEPARKING_DB_PORT}"
EOF


cat > /srv/mapserver/connection_basiskaart.inc <<EOF
CONNECTIONTYPE postgis
CONNECTION "host=${BASISKAART_DB_HOST} dbname=${BASISKAART_DB_NAME} user=${BASISKAART_DB_USER} password=${BASISKAART_DB_PASSWORD} port=${BASISKAART_DB_PORT}"
PROCESSING "CLOSE_CONNECTION=DEFER"
EOF

cat > /srv/mapserver/connection_handelsregister.inc <<EOF
CONNECTIONTYPE postgis
CONNECTION "host=${HANDELSREGISTER_DB_HOST} dbname=${HANDELSREGISTER_DB_NAME} user=${HANDELSREGISTER_DB_USER} password=${HANDELSREGISTER_DB_PASSWORD} port=${HANDELSREGISTER_DB_PORT}"
PROCESSING "CLOSE_CONNECTION=DEFER"
EOF

cat > /srv/mapserver/connection_tellus.inc <<EOF
CONNECTIONTYPE postgis
CONNECTION "host=${TELLUS_DB_HOST} dbname=${TELLUS_DB_NAME} user=${TELLUS_DB_USER} password=${TELLUS_DB_PASSWORD} port=${TELLUS_DB_PORT}"
EOF

echo Starting server
apachectl -D FOREGROUND

