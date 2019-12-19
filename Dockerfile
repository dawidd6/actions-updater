FROM ruby:2.6-alpine as builder
WORKDIR /app
COPY . /app
RUN gem build *.gemspec

FROM ruby:2.6-alpine
WORKDIR /app
COPY --from=builder /app/*.gem /app
RUN gem install /app/*.gem
RUN apk -U add git
ENTRYPOINT ["actions-updater"]
