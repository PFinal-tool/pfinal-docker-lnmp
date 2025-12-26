FROM php:8.5.0-fpm

# 设置时区
ENV TZ=Asia/Shanghai

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    gcc \
    make \
    autoconf \
    openssl \
    libssl-dev \
    curl \
    libbz2-dev \
    libxml2-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libzip-dev \
    freetds-bin \
    freetds-common \
    libcurl4-gnutls-dev \
    libonig-dev \
    libicu-dev \
    libxslt-dev \
    libsnmp-dev \
    snmp \
    libpspell-dev \
    aspell-en \
    libtidy-dev \
    pkg-config \
    libzstd-dev \
    && ln -s /usr/lib/x86_64-linux-gnu/libsybdb.so /usr/lib/ \
    && rm -rf /var/lib/apt/lists/*

# 安装SSL证书
RUN apt-get update && apt-get install -y \
    ca-certificates \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 配置 GD 扩展
RUN docker-php-ext-configure gd --with-jpeg --with-freetype

# 第一组：核心数据库和基础扩展
RUN docker-php-ext-install -j$(nproc) \
    pdo \
    pdo_mysql \
    mysqli \
    mbstring \
    bcmath

# 第二组：GD 和 XML 相关扩展  
RUN docker-php-ext-install -j$(nproc) \
    gd \
    intl \
    soap \
    xsl \
    exif

# 第三组：压缩和进程控制扩展
RUN docker-php-ext-install -j$(nproc) \
    bz2 \
    zip \
    pcntl \
    calendar \
    gettext

# 第四组：系统 IPC 扩展
RUN docker-php-ext-install -j$(nproc) \
    sockets \
    shmop \
    sysvmsg \
    sysvsem \
    sysvshm

# 第五组：其他数据库扩展（可选）
# RUN docker-php-ext-install -j$(nproc) \
#     pdo_firebird \
#     pdo_dblib \
#     dba

# 第六组：其他扩展
RUN docker-php-ext-install -j$(nproc) \
    snmp \
    tidy


# 更新PECL通道并安装扩展
RUN pecl channel-update pecl.php.net && \
    # Redis
    (pecl install redis || pecl install -f redis) && \
    docker-php-ext-enable redis && \
    # Protobuf
    (pecl install protobuf || pecl install -f protobuf) && \
    docker-php-ext-enable protobuf && \
    # Swoole
    # (pecl install swoole || pecl install -f swoole) && \
    # docker-php-ext-enable swoole

# 安装Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# 配置PHP
RUN { \
    echo 'opcache.memory_consumption=128'; \
    echo 'opcache.interned_strings_buffer=8'; \
    echo 'opcache.max_accelerated_files=4000'; \
    echo 'opcache.revalidate_freq=60'; \
    echo 'opcache.fast_shutdown=1'; \
    echo 'opcache.enable_cli=1'; \
} > /usr/local/etc/php/conf.d/opcache-recommended.ini

# 设置时区
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

