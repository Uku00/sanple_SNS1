FROM ruby:3.0

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get update -qq && \
    apt-get install -y nodejs default-mysql-client imagemagick && \
    npm install -g yarn　
    

WORKDIR /app

COPY Gemfile ./
RUN bundle config set --local path 'vendor/bundle'
RUN bundle install

COPY . /app
