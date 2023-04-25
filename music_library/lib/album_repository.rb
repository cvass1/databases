
class AlbumRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, release_year,artist_id FROM albums;

    # Returns an array of Album objects.

    sql = 'SELECT id, title, release_year,artist_id FROM albums;'
    result_set = DatabaseConnection.exec_params(sql, [])

    albums = []

    result_set.each do |record|
      album = Album.new
      album.id = record['id']
      album.title = record['title']
      album.release_year = record['release_year']
      album.artist_id = record['artist_id']
      
      albums << album
    end

    return albums
  end
 
  def find(id)
    # Gets a single record by its ID
    # One argument: the id (number)
    # Executes the SQL query:
    # Returns a single Album object.
    sql = 'SELECT id, title, release_year,artist_id FROM albums WHERE id = ' + id.to_s
    result = DatabaseConnection.exec_params(sql, []).to_a[0]

    album = Album.new
    album.id = result['id']
    album.title = result['title']
    album.release_year = result['release_year']
    album.artist_id = result['artist_id']

    return album
  
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(album)
  # end

  # def update(album)
  # end

  # def delete(album)
  # end
end