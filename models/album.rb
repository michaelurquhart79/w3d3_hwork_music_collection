require("pg")
require_relative("../db/sql_runner")

class Album

  attr_reader :id, :artist_id
  attr_accessor :title, :genre

  def initialize(options)
    @title = options["title"]
    @genre = options["genre"]
    @id = options["id"].to_i if options["id"]
    @artist_id = options["artist_id"]
  end

  def save()
    sql = "INSERT INTO albums
    (
      title,
      genre,
      artist_id
    ) VALUES
    (
      $1, $2, $3
    ) RETURNING id"
    values = [@title, @genre, @artist_id]
    result = SqlRunner.run(sql, values)[0]
    @id = result["id"].to_i
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE albums SET (
      title,
      genre,
      artist_id
    ) =
    (
      $1, $2, $3
    ) WHERE id = $4"
    values = [@title, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values =[@artist_id]
    result = SqlRunner.run(sql, values)[0]
    return Artist.new(result)
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    array_of_hashes = SqlRunner.run(sql)
    array_of_objects = array_of_hashes.map {|hash| Album.new(hash)}
    return array_of_objects
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    album_hash = SqlRunner.run(sql, values)[0]
    album_object = Album.new(album_hash)
    return album_object
  end

end
