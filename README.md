# Outlands Ministry of Arts and Sciences Site

## Usage
Install Docker.
* Mac: https://store.docker.com/editions/community/docker-ce-desktop-mac

From the root of this directory, do
```
docker-compose -f docker-compose.yml up
```
This sets up a full Drupal site at http://localhost:8080

The admin user and password for the site are 'admin'.


# Add to build:
install vim, git
php -d memory_limit=2048M /usr/local/bin/composer install --prefer-dist

# copy updated db to container
* download copy of db locally, replace drupal.sql in /etc/mysql

docker exec -i moas_mysql_1 mysql -uroot -p12345 drupal < drupal.sql

Copy modules, themes in place


php_value upload_max_filesize 10M
php_value post_max_size 10M
