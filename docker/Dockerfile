FROM ruby:2.5.1-alpine

ENV LANG ja_JP.UTF-8
ENV BUILD_PACKAGES="curl-dev build-base" \
    DEV_PACKAGE="mariadb-libs mariadb-client mariadb-client-libs tzdata"

RUN gem install bundler \
  && apk --update --upgrade add $BUILD_PACKAGES \
  && apk add mariadb-dev tzdata linux-headers postgresql-dev sqlite-dev git nodejs \
  && rm /usr/lib/libmysqld* \
  && echo 'gem: --no-document' > /etc/gemrc \
  && mkdir -p /var/www

WORKDIR var/www
COPY Gemfile /var/www/Gemfile
COPY Gemfile.lock /var/www/Gemfile.lock
RUN bundle install --jobs=4

EXPOSE  3000
