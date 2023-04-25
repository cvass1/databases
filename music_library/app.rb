require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/album'



# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

# Perform a SQL query on the database and get the result set.
# sql = 'SELECT * FROM artists;'
sql = 'SELECT id, title FROM albums;'
result = DatabaseConnection.exec_params(sql, [])

# Print out each record from the result set .
result.each do |record|
  p record
end

album_repository = AlbumRepository.new

album_14 = album_repository.find(14)
puts album_14.title
