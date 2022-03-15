FROM ghcr.io/rbrownwsws/k8s-backup-tool:1
COPY run.sh /
RUN chmod +x /run.sh
CMD ["/run.sh"]
