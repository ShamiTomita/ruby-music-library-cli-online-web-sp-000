require 'pry'
class MusicLibraryController 
  extend Concerns::Findable
  
  def initialize(path='./db/mp3s')
    newImporter = MusicImporter.new(path)
    Song.all << newImporter.import
  end
  
  def library(klass = Song ) #importing the Song class into this class so we can create a library of all the songs
    sorted_library = klass.all.collect{|obj| obj if obj.class == klass}
    sorted_library = sorted_library.delete_if {|obj| obj == nil}
    sorted_library.uniq
  end 

  def call 
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = nil
    input = gets.chomp
    case input 
    when "list songs"
      self.list_songs 
    when "list artists"
      self.list_artists
    when "list genres"
      self.list_genres
    when "list artist"
      self.list_songs_by_artist
    when "list genre"
      self.list_songs_by_genre
    when "play song"
      self.play_song
    when "exit"
      'exit'
    else 
      call
    end 
  end
  
  def list_songs
    sorted_library = self.library.sort_by {|song|song.name}
    sorted_library.each do |song|
      puts "#{sorted_library.index(song) + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  
  def song_array
    sorted_library = self.library.sort_by {|song|song.name}
    sorted_library.collect do |song|
      "#{sorted_library.index(song) + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  
  def list_artists
    sorted_library = self.library(Artist).sort_by {|artist| artist.name}
    artists = sorted_library.collect {|artist| "#{artist.name}"}.uniq
    artists.each {|artist| puts "#{artists.index(artist) + 1}. #{artist}"}
  end 
  
  def list_genres
    sorted_library = self.library(Genre).sort_by {|genre| genre.name}
    genres = sorted_library.collect {|genre| "#{genre.name}"}.uniq 
    genres.each {|genre| puts "#{genres.index(genre) + 1}. #{genre}"}
  end 
  
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp 
    artist_songs = []
    self.library.each do |song|
      if song.artist.name == input 
        artist_songs << song 
      end 
    end 
    artist_songs = artist_songs.sort_by{|song| song.name}
    artist_songs.each {|song| puts "#{artist_songs.index(song) + 1}. #{song.name} - #{song.genre.name}"} unless artist_songs == nil
  end 

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp 
    genre_songs = []
    self.library.each do |song|
      if song.genre.name == input 
        genre_songs << song 
      end 
    end 
    genre_songs = genre_songs.sort_by{|song| song.name}
    genre_songs.each {|song| puts "#{genre_songs.index(song) + 1}. #{song.artist.name} - #{song.name}"} unless genre_songs == nil
  end 
  
  def play_song
    puts "Which song number would you like to play?"
    song_names = self.song_array
    user_input = gets.chomp.to_i
    if user_input > 0 && user_input <= self.library.size
      chosen_input = song_names[user_input - 1]
      chosen_input = name_extractor(chosen_input)[1]
      song = Song.find_by_name(chosen_input)
      puts "Playing #{song.name} by #{song.artist.name}" unless song == nil
    end
  end
    
  def name_extractor(filename)
    #Returns an array, first value is artist, second is song, third is genre
    file_bits = filename.gsub(/(\.mp3)/,'')
    file_bits = file_bits.split(" - ")
  end
  
  
  
end 

