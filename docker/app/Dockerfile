FROM ruby:3.3.5-bullseye

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

ARG UID=1000
ARG GID=1000

RUN apt-get update -qq \
  && apt-get -y install --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* && apt-get clean \
  && groupadd -g ${GID} ruby \
  && useradd --create-home --no-log-init -u ${UID} -g ${GID} ruby \
  && chown ruby:ruby -R /app

COPY --chown=ruby:ruby ./src /app

USER ruby

WORKDIR /app

RUN bundle install
