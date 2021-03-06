require("pg")
require_relative("../db/sql_runner")

class Artist
  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @name = options["name"]
    @id = options["id"] if options["id"]
  end

  def save()
    sql = "INSERT INTO artists
    (
      name
    ) VALUES
    (
      $1
    ) RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE artists SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def albums()
    sql = "SELECT * from albums WHERE artist_id = $1"
    values = [@id]
    array_of_hashes = SqlRunner.run(sql, values)
    array_of_objects = array_of_hashes.map{|hash| Album.new(hash)}
    return array_of_objects
  end


  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM artists"
    array_of_hashes = SqlRunner.run(sql)
    array_of_objects = array_of_hashes.map {|hash| Artist.new(hash)}
    return array_of_objects
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    artist_hash = SqlRunner.run(sql, values)[0]
    artist_object = Artist.new(artist_hash)
    return artist_object
  end

end
