FROM snowdreamtech/frps:latest

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 7000 7500 8000 8443 2222

ENTRYPOINT ["/entrypoint.sh"]
