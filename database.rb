ActiveRecord::Migrator.migrations_paths = [
  File.expand_path('../db/migrate/', __FILE__)
]

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: ENV['REDDIT_DB']
)

ActiveRecord::Tasks::DatabaseTasks.migrate if ENV['REDDIT_ENV'] == 'test'
