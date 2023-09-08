FROM ruby:3.2.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /docker_rails
WORKDIR /docker_rails
ADD Gemfile /docker_rails/Gemfile
ADD Gemfile.lock /docker_rails/Gemfile.lock
RUN bundle install
ADD . /docker_rails

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
