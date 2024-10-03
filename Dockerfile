# PHP 5.5 + Apache の公式イメージをベースに使用
FROM php:5.5-apache

# アーカイブリポジトリを使って依存関係をインストール
RUN sed -i 's/httpredir.debian.org/archive.debian.org/g' /etc/apt/sources.list \
    && sed -i '/jessie-updates/d' /etc/apt/sources.list \
    && sed -i '/security.debian.org/d' /etc/apt/sources.list \
    && apt-get update -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false \
    && apt-get install -y --allow-unauthenticated \
    libxml2-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zlib1g-dev \
    && docker-php-ext-install pdo_mysql mbstring xml

# Apacheの設定を行う場合は以下を追加
# COPY ./my-apache-config.conf /etc/apache2/sites-available/000-default.conf

# Document root を指定
WORKDIR /var/www/html

# HTTPポートの公開
EXPOSE 80
