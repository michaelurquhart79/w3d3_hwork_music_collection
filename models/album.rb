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

end
