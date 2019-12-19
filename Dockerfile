FROM ruby:2.6-alpine
COPY . /app
WORKDIR /app
RUN apk -U add git
RUN bundle install
RUN rake install
ENTRYPOINT ["actions-updater"]
