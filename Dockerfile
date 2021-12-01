FROM ruby:3.0

LABEL maintainer="rudi.zeilhofer@xp360.de"

# install the latest nodejs
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  nodejs \
  telnet \
  yarn

# cache-trick for bundle install
COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
ENV BUNDLE_PATH /gems
RUN bundle install

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

COPY . /usr/src/app/

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["bin/rails", "s", "-b", "0.0.0.0"]