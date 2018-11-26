FROM ruby AS builder

COPY Gemfile* /src/
COPY Makefile /src/
WORKDIR /src
RUN bundle install

RUN apt-get update && apt-get -y install \
  curl
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash 
RUN apt-get install -y \
  nodejs
RUN npm install broken-link-checker typedoc
CMD make serve
