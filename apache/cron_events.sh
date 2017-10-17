#!/bin/bash

while :
do
	# Для старых версий bitrix
	# php -f /var/www/html/bitrix/php_interface/cron_events.php
	# touch /var/www/html/bitrix/php_interface/cron_events_last
	# Для новых версий битрикс
	php -f /var/www/html/bitrix/modules/main/tools/cron_events.php
        touch /var/www/html/bitrix/modules/main/tools/cron_events_last
	sleep $1
done
