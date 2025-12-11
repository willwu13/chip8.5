# Use Ruby 2.6.10 (compatible with Rails 4.2)
FROM ruby:2.6.10

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs sqlite3 libsqlite3-dev

WORKDIR /app

# Copy gem definitions and install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 1.17.3
RUN bundle _1.17.3_ install

# Copy the rest of the app
COPY . .

# Precompile assets if you use them (skip if none)
# RUN RAILS_ENV=production bundle exec rake assets:precompile

# Expose port (for local testing — Heroku uses $PORT automatically)
EXPOSE 3000

# Default command to run — uses the PORT env var that Heroku sets
CMD ["bash", "-c", "bundle exec rails server -b 0.0.0.0 -p ${PORT:-3000}"]
