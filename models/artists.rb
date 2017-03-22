require('pg')
require_relative('../db/sql_runner')

class Artist

  attr_reader :id
  attr_accessor :artist_name

  def initialize(options)
    @id           = options['id'].to_i
    @artist_name  = options['artist_name']
  end

  def save()
    sql = "INSERT INTO artists (artist_name) VALUES ('#{@artist_name}') RETURNING * "
    result = SqlRunner.run(sql)
    @id = result.first()['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    result = SqlRunner.run(sql)
  end

  def discography
    sql = "SELECT * from albums WHERE artist_id = #{id}"
    result = SqlRunner.run(sql)
    albums = result.map{|album| Album.new(album)}
    return albums
  end

  # def update_artist
  #   sql = "UPDATE artists SET (artist_name) = ('#{@artist_name}') WHERE id = #{@id}"
  #   result = SqlRunner.run(sql)
  # end

  def delete
    sql = "DELETE FROM artists WHERE id = #{@id}"
    result = SqlRunner.run(sql)
  end


  def self.all()
    sql = "SELECT * FROM artists"
    result = SqlRunner.run(sql)
    artists = result.map {|artist| Artist.new(artist)}
    return artists
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = #{id}"
    result = SqlRunner.run(sql)
  end



end