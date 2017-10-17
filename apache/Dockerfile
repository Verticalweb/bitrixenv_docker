# Файл сборки образа модуля apache
# подключаем родительский модуль. php5.6-apache
FROM php:5.6-apache
# затем, можно устанавливать необходимые пакеты для работы
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        ssmtp \
        gettext \
	php5-mysql \
	php5-xcache \
	unzip \
        screen && \
        rm -r /var/lib/apt/lists/*

RUN apt-get update && apt-get install -q -y sendmail mailutils && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd mysqli mcrypt pdo pdo_mysql mbstring tokenizer iconv
# настраиваем пользователя apache
RUN a2enmod rewrite
RUN usermod -u 1000 www-data
RUN groupmod -g 1000 www-data

# копируем в контейнер дополнительные, заранее подготовленные
# конфигурационные файлы и скрипты

COPY start.sh /usr/local/sbin/start.sh
#COPY php-mail.ini /usr/local/etc/php/conf.d/mail.ini
COPY bitrix.ini /usr/local/etc/php/conf.d/
COPY date-timezone.conf /etc/apache2/conf-enabled/date-timezone.conf
COPY encoding.conf /etc/apache2/conf-enabled/encoding.conf
COPY servername.conf.tmpl /etc/apache2/conf-enabled/servername.conf.tmpl
COPY revaliases.tmpl /etc/ssmtp
#COPY ssmtp.conf.tmpl /etc/ssmtp
ADD senddoc.sh /home/senddoc.sh

RUN echo "sendmail_path=sendmail -i -t" >> /usr/local/etc/php/conf.d/php-sendmail.ini

COPY cron_events.sh /usr/local/sbin/cron_events.sh
# скрипт размещенный здесь, запускается автоматически после запуска контейнера
# пока работает этот скрипт, работает контейнер.
# как только скрипт окончит свою работу, контейнер остановиться
CMD ["/usr/local/sbin/start.sh"]
