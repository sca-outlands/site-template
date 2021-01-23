# Outlands Template docker build
FROM drupal:8.9-apache

MAINTAINER Graf Iohann der Vuhs

# Add some necessary utilities
RUN \
  apt-get -y update && apt-get -y install vim git patch

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Remove symlink to elsewhere; we're going to replace this whole directory
RUN rm /var/www/html

# Set the default working directory
VOLUME ["/var/www/html"]
WORKDIR /var/www/html/

# Override any previous entrypoint
CMD ["/entrypoint.sh"]
