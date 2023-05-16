# backend/Dockerfile

FROM ruby:3.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /yakudou-app
WORKDIR /yakudou-app
COPY Gemfile /yakudou-app/Gemfile
COPY Gemfile.lock /yakudou-app/Gemfile.lock
RUN bundle install
COPY . /yakudou-app

# entrypoint.shは初回起動時のみに処理したい内容を記述するヘルパースクリプト
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
