#!/bin/bash

# Migrate and seed database
php "/var/www/html/artisan" migrate --force --isolated
php "/var/www/html/artisan" db:seed --force

# Refresh caches
php "/var/www/html/artisan" optimize:clear
php "/var/www/html/artisan" optimize
php "/var/www/html/artisan" icon:cache
php "/var/www/html/artisan" filament:cache-components

# Create storage symlinks
php "/var/www/html/artisan" storage:link

# Start Supervisor
exec supervisord -c /etc/supervisor/supervisord.conf
