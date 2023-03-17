# build-time image
FROM ruby:3.2.1-alpine3.17

ENV WORKDIR="/opt/ruby"

# Libraries required for build-time. Note - If we need nokogiri we will need to add libxml2 to runtime as well
RUN apk update && apk --no-cache add make libxml2 libxslt-dev g++ openssl openssl-dev git zip

ENV APP_HOME /app

RUN mkdir $APP_HOME

COPY . $APP_HOME

WORKDIR $APP_HOME

RUN bundle config timeout 30
RUN bundle config deployment 'true'
RUN bundle config retry 4
RUN bundle install

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
