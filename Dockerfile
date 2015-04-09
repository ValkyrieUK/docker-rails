FROM seapy/ruby:2.2.0
MAINTAINER ChangHoon Jeong <iamseapy@gmail.com>

RUN locale-gen en_GB.UTF-8
RUN apt-get update

# Install nodejs
RUN apt-get install -qq -y nodejs

# Intall software-properties-common for add-apt-repository
RUN apt-get install -qq -y software-properties-common

# Install Nginx.
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN apt-get install -qq -y nginx
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx
# Add default nginx config
ADD nginx-sites.conf /etc/nginx/sites-enabled/default

# Install foreman
RUN gem install foreman

# Install the latest postgresql lib for pg gem
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --force-yes libpq-dev

## Install MySQL(for mysql, mysql2 gem)
RUN apt-get install -qq -y libmysqlclient-dev

# Install Rails App
WORKDIR /application
ONBUILD ADD Gemfile /application/Gemfile
ONBUILD ADD Gemfile.lock /application/Gemfile.lock
ONBUILD RUN bundle install --without development test
ONBUILD ADD . /application

# Add default unicorn config
ADD unicorn.rb /application/config/unicorn.rb

# Add default foreman config
ADD Procfile /application/Procfile

RUN bundle exec rake assets:precompile

ENV RAILS_ENV production

EXPOSE 80

ENTRYPOINT bundle exec foreman start -f Procfile