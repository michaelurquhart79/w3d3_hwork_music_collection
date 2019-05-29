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

end
