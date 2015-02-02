FROM ubuntu:latest
MAINTAINER Romans <me@nearly.guru>

# This dockerfile is suitable for installing MantisBT
# for production use. The script will also look for /data volume
# where it would move permanent files MantisBT creates (attachments)
#

RUN apt-get update
RUN apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \

        mysql-client \
        apache2 \
        libapache2-mod-php5 \
        php5-mysql  \
        php5-ldap \
        php5-gd \
        php5-curl \
        wget \
        php-pear && rm -rf /var/lib/apt/lists/*

RUN sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini
RUN sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/cli/php.ini

RUN a2enmod rewrite
RUN a2enmod headers

RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html

# Install vanilla MantisBT
RUN wget http://sourceforge.net/projects/mantisbt/files/latest/download -O /mantisbt.zip
RUN unzip /mantisbt.zip
RUN cp -aR /wordpress/* /app
RUN chown -R www-data:www-data /app

# Use our default config
ADD config_inc.php /app/config_inc.php

# Initialize custom config from volume
ADD volume-init.sh /volume-init.sh
RUN chmod 755 /volume-init.sh

# Configure and start apache
ADD vhost.conf /etc/apache2/sites-enabled/000-default.conf
ADD run.sh /run.sh

EXPOSE 80
WORKDIR /app
CMD ["/run.sh"]

