#!/bin/sh

cat > /usr/bin/run_curator.sh <<EOF
#!/bin/sh

/usr/local/bin/curator_cli --host ${ELASTIC_HOST} --port ${ELASTIC_PORT} delete_indices --ignore_empty_list --filter_list '[{"filtertype": "age", "source": "name", "direction": "older", "unit": "${RETENTION_UNIT_TYPE}", "unit_count": ${RETENTION_UNITS}, "timestring": "${RETENTION_TIME_STRING}"}, {"filtertype": "pattern", "kind": "regex", "value": "${RETENTION_INDEX_PATTERN}"}]'
EOF

chmod +x /usr/bin/run_curator.sh

cat > /etc/cron.d/curator_cron <<EOF
${CRON_PERIOD} /usr/bin/run_curator.sh >> /var/log/cron.log 2>&1
EOF

chmod 0644 /etc/cron.d/curator_cron
crontab /etc/cron.d/curator_cron

touch /var/log/cron.log

cron && tail -f /var/log/cron.log
