FROM ruby:2.6-alpine
COPY . /app
WORKDIR /app
RUN bundle install
RUN rake install
ENTRYPOINT ["actions-updater"]
