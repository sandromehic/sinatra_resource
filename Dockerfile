FROM ruby:2.2-alpine
MAINTAINER UNIFI f4w dev team <devs@facts4.work>

ENV BUNDLER_VERSION=1.13.5
ENV RACK_ENV=production

#RUN apk add --update ruby-dev linux-headers make gcc libc-dev 
RUN apk -U add ruby-dev openssl-dev alpine-sdk

RUN gem install bundler -v $BUNDLER_VERSION && bundle config --global frozen 1

RUN mkdir -p /usr/src && adduser -h /usr/src/app -D app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/Gemfile
COPY Gemfile.lock /usr/src/app/Gemfile.lock

RUN bundle install

COPY . /usr/src/app

EXPOSE 4567
CMD ["ruby", "lib/resource.rb"]
