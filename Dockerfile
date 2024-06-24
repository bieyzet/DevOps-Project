# PHP 7.3 sürümünü baz alan resmi PHP Apache görüntüsünü kullanıyoruz
FROM php:7.3.33-apache

# Apache mod_rewrite modülünü etkinleştiriyoruz (URL yeniden yazımı için gereklidir)
RUN a2enmod rewrite

# PHP eklenti gereksinimlerini kuruyoruz (örneğin: mysqli, pdo_mysql gibi)
RUN docker-php-ext-install mysqli pdo_mysql

# Çalışma dizinini /var/www/html altına ayarlıyoruz (Apache'nin varsayılan kök dizini)
WORKDIR /var/www/html

# Lokal projenizin dosyalarını Docker görüntüsüne kopyalıyoruz
COPY . .

# Composer'ı indirip yüklüyoruz (projede Composer kullanılıyorsa)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Composer ile bağımlılıkları yüklüyoruz (composer.json ve composer.lock dosyalarına göre)
RUN composer install --no-dev --optimize-autoloader

# Docker konteynerı açıldığında Apache'yi başlatıyoruz
CMD ["apache2-foreground"]
