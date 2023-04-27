require 'album_repository'
require 'album'

def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe AlbumRepository do
  before(:each) do 
    reset_albums_table
  end
   
  it 'gets all the albums' do
    repo = AlbumRepository.new

    albums = repo.all

    expect(albums.length).to eq 3

    expect(albums[0].id).to eq 1
    expect(albums[0].title).to eq 'Doolittle'
    expect(albums[0].release_year).to eq 1989
    expect(albums[0].artist_id).to eq 1

    expect(albums[1].id).to eq 2
    expect(albums[1].title).to eq 'Surfer Rosa'
    expect(albums[1].release_year).to eq 1988
    expect(albums[1].artist_id).to eq 1
  end

  it 'gets a single album' do
    repo = AlbumRepository.new

    album = repo.find(1)

    expect(album.id).to eq 1
    expect(album.title).to eq 'Doolittle'
    expect(album.release_year).to eq  1989
    expect(album.artist_id).to eq 1
  end

  it 'creates a new record' do
    repo = AlbumRepository.new

    album = Album.new

    album.title = 'Definitely Maybe'
    album.release_year = 1994
    album.artist_id = 3

    repo.create(album)

    album_last = repo.all.last
    expect(album_last.title).to eq 'Definitely Maybe'
    expect(album_last.release_year).to eq 1994
    expect(album_last.artist_id).to eq 3
  end

  it 'deletes a record' do
    repo = AlbumRepository.new

    repo.delete(3)

    album_last = repo.all.last
    expect(album_last.title).to eq 'Surfer Rosa'
    expect(album_last.release_year).to eq 1988
    expect(album_last.artist_id).to eq 1
  end

  it 'updates a record' do
    repo = AlbumRepository.new

    album = repo.find(3)

    album.title = 'No Longer Waterloo'
    album.release_year = 2023
    album.artist_id = 10

    repo.update(album)

    updated_album = repo.find(3)

    expect(updated_album.title).to eq 'No Longer Waterloo'
    expect(updated_album.release_year).to eq 2023
    expect(updated_album.artist_id).to eq 10
  end
  
end