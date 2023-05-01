require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/album'

# album_repository = AlbumRepository.new
# album_14 = album_repository.find(14)
# puts album_14.title
# album_repository.all.each{ |album|
# puts "#{album.id}) Title: #{album.title}, Release Year: #{album.release_year}"
# }
# album_3 = album_repository.find(3)
# puts "\n#{album_3.id} - #{album_3.title} - #{album_3.release_year} "


class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
    @io.puts "Welcome to the music library manager!\nWhat would you like to do?\n1 - List all albums\n2 - List all artists\nEnter your choice:"
    user_input = @io.gets.chomp.to_i
    @io.puts ""
    if user_input == 1 then
      # get a list of all albums
      @album_repository.all.each{ |record|
      @io.puts "#{record.id} - #{record.title}"}
    end


  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    "artist_repo" #ArtistRepository.new
  )
  app.run
end




# Phase 3 notes
# Exercise One query

# SELECT albums.id,
# 	albums.title
# FROM albums
# JOIN artists
# ON albums.artist_id = artists.id
# WHERE artists.name = 'Taylor Swift'
# ;

# Exercise Two 

# SELECT albums.id,
# 	albums.title
# FROM albums
# JOIN artists
# ON albums.artist_id = artists.id
# WHERE artists.name = 'Pixies' AND
# 	albums.release_year = 1988
# ;

# Challenge:

# SELECT albums.id AS album_id,
# 	albums.title
# FROM albums
# JOIN artists
# ON albums.artist_id = artists.id
# WHERE artists.name = 'Nina Simone' AND
# 	albums.release_year > 1975
# ;

