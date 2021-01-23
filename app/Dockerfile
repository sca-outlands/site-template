# Outlands Template docker build
FROM drupal:8.9-apache

MAINTAINER Graf Iohann der Vuhs

# Add some necessary utilities
RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get -y update && \
  apt-get -y install vim git patch

COPY ./cmd.sh /cmd.sh
RUN chmod +x /cmd.sh

# Remove symlink to elsewhere; we're going to replace this whole directory
RUN rm /var/www/html

# Set the default working directory
WORKDIR /var/www/html/

# Override any previous cmd
CMD ["/cmd.sh"]
