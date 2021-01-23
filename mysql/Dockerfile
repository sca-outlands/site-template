# Outlands Template docker build
FROM mysql:5.7

MAINTAINER Ulric of Thorne

COPY ./entrypoint-wrapper.sh /entrypoint-wrapper.sh
RUN chmod +x /entrypoint-wrapper.sh
ENTRYPOINT ["/entrypoint-wrapper.sh"]
CMD ["mysqld"]
