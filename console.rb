require('pry')
require_relative('./models/albums')
require_relative('./models/artists')

Album.delete_all
Artist.delete_all

artist1 = Artist.new('artist_name' => 'Arctic Monkeys')
artist1.save()

album1 = Album.new({'album_name' => 'Whatever people say I am, thats what Im not', 'artist_id' => artist1.id, 'genre' => 'rock'})
album1.save()

artist2 = Artist.new('artist_name' => 'The Beatles')
artist2.save()

album2 = Album.new({'album_name' => 'White album', 'artist_id' => artist2.id, 'genre' => 'classic'})
album2.save()

album3 = Album.new({'album_name' => 'Sgt. peppers', 'artist_id' => artist2.id, 'genre' => 'classic'})
album3.save()

album2.delete()

Artist.find(artist1.id)
Album.find(album3.id)

binding.pry

return nil
