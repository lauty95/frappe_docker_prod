#!/bin/bash

export SERVER=server:8000
export SOCKETIO=websocket:9000
export UPSTREAM_REAL_IP_ADDRESS=127.0.0.1
export UPSTREAM_REAL_IP_HEADER=X-Forwarded-For
export UPSTREAM_REAL_IP_RECURSIVE=off
export FRAPPE_SITE_NAME_HEADER=$SITE_NAME
export PROXY_TIMEOUT=120
export CLIENT_MAX_BODY_SIZE=50m

echo ">>> ${FRAPPE_SITE_NAME_HEADER} <<< ${SERVER} || $(printenv) @@@@@@"

envsubst '${SERVER}
  ${SOCKETIO}
  ${UPSTREAM_REAL_IP_ADDRESS}
  ${UPSTREAM_REAL_IP_HEADER}
  ${UPSTREAM_REAL_IP_RECURSIVE}
  ${FRAPPE_SITE_NAME_HEADER}
  ${PROXY_TIMEOUT}
	${CLIENT_MAX_BODY_SIZE}' \
  </templates/nginx/frappe.conf.template >/etc/nginx/conf.d/frappe.conf

nginx -g 'daemon off;'
