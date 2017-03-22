require('pg')
require_relative('../db/sql_runner')

class Album

  attr_reader :id, :artist_id, :genre
  attr_writer :album_name

  def initialize(options)
    @id         = options['id'].to_i
    @album_name = options['album_name']
    @artist_id  = options['artist_id'].to_i
    @genre      = options['genre']
  end

  def save()
    sql = "INSERT INTO albums (album_name, artist_id, genre) VALUES ('#{@album_name}', #{@artist_id}, '#{@genre}' ) RETURNING * "
    result = SqlRunner.run(sql)
    @id = result.first()['id'].to_i
  end

  def list_artist
    sql = "SELECT * FROM artists WHERE id = #{artist_id}"
    result = SqlRunner.run(sql)
    artist_detail = result[0]
    artist = Artist.new(artist_detail)
    return artist
  end

  def self.delete_all
    sql = "DELETE FROM albums"
    result = SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM albums"
    result = SqlRunner.run(sql)
    albums = result.map{|album| Album.new(album)}
    return albums
  end

end