FROM ruby:2.6.6

ENV NODE_VERSION 10.12.0
ENV BUNDLER_VERSION 1.17.3

ENV LANG C.UTF-8

# https://stackoverflow.com/questions/55361762/apt-get-update-fails-with-404-in-a-previously-working-build
RUN sed -i '/jessie-updates/d' /etc/apt/sources.list

RUN apt-get update -qq && apt-get install -y build-essential git mariadb-client

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get -y -qq install nodejs
RUN npm install -g phantomjs-prebuilt --unsafe-perm

RUN gem install bundler -v $BUNDLER_VERSION

RUN mkdir /app
WORKDIR /app
