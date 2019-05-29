require("pry")
require_relative("../models/album")
require_relative("../models/artist")

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({"name" => "Nirvana"})
artist1.save()

artist2 = Artist.new({"name" => "Pearl Jam"})
artist2.save()

artist3 = Artist.new({"name" => "Green River"})
artist3.save()



album1 = Album.new({
  "title" => "Ten",
  "genre" => "Alternative",
  "artist_id" => artist2.id
  })

album1.save()

album2 = Album.new({
  "title" => "Nevermind",
  "genre" => "Grunge",
  "artist_id" => artist1.id
  })

album2.save()

album3 = Album.new({
  "title" => "In Utero",
  "genre" => "Grunge",
  "artist_id" => artist1.id
  })

album3.save()




binding.pry

nil
