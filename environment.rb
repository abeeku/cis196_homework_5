# Set up environment variables
ENV['REDDIT_ENV'] ||= 'development'

ENV['REDDIT_DB'] ||= ':memory:' if ENV['REDDIT_ENV'] == 'test'
ENV['REDDIT_DB'] ||= "db/#{ENV['REDDIT_ENV']}.sqlite3"
