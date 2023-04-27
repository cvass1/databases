
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
      album.id = record['id'].to_i
      album.title = record['title']
      album.release_year = record['release_year'].to_i
      album.artist_id = record['artist_id'].to_i
      
      albums << album
    end

    return albums.sort_by! {|album| album.id}
    
  end
 
  def find(id)
    # Gets a single record by its ID
    # One argument: the id (number)
    # Executes the SQL query:
    # Returns a single Album object.
    sql = 'SELECT id, title, release_year,artist_id FROM albums WHERE id = $1;'
    sql_params = [id]
    result = DatabaseConnection.exec_params(sql, sql_params)
    record = result[0]

    album = Album.new
    album.id = record['id'].to_i
    album.title = record['title']
    album.release_year = record['release_year'].to_i
    album.artist_id = record['artist_id'].to_i

    return album
  
  end

  # Add more methods below for each operation you'd like to implement.

  def create(album)
    sql = 'INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3);'
    sql_params = [album.title, album.release_year, album.artist_id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil

  end

  def update(album)
    sql = 'UPDATE albums SET title = $1, release_year = $2, artist_id = $3 WHERE id = $4;'
    sql_params = [album.title, album.release_year, album.artist_id, album.id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil

  end

  def delete(id)
    sql = 'DELETE FROM albums WHERE id = $1;'
    sql_params = [id]

    DatabaseConnection.exec_params(sql,sql_params)

    return nil
  end
end