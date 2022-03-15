#!/bin/sh

set -e

PAPERLESS_NAMESPACE="${PAPERLESS_NAMESPACE:-paperless}"
PAPERLESS_POD="${PAPERLESS_POD:-paperless}"

PAPERLESS_EXPORT_MOUNT="${PAPERLESS_EXPORT_MOUNT:-/mnt/export}"
BACKUP_REMOTE="${BACKUP_REMOTE:-/mnt/backup}"

RCLONE_CONFIG="${RCLONE_CONFIG:=/etc/rclone/rclone.conf}"

echo "##############################"
echo "## Exporting Paperless data ##"
echo "##############################"
echo ""

kubectl exec --tty -n "${PAPERLESS_NAMESPACE}" "pod/${PAPERLESS_POD}" -- python ./manage.py document_exporter --delete --use-filename-format ../export
echo ""

echo "#################################################"
echo "## Copying Paperless export to backup location ##"
echo "#################################################"
echo ""

rclone --config="${RCLONE_CONFIG}" --log-level INFO sync "${PAPERLESS_EXPORT_MOUNT}" "${BACKUP_REMOTE}"
