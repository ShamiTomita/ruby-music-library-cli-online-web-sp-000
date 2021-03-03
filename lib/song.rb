class Song 
  extend Concerns::Findable
  extend Persistable::ClassMethods 
  include Persistable::InstanceMethods
  attr_accessor :name, :artist, :genre

  @@all = [] 
  
  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist=(artist) if artist != nil
    self.genre=(genre) if genre != nil
  end
  
 # def save 
  #  @@all << self 
  #end 
  
  def self.all 
    @@all
  end 
  
 # def self.destroy_all
  #  @@all.clear
  #end
   
  def artist=(artist)
    if @artist == nil
      @artist = artist
    else
      @artist = @artist
    end
    if self.artist != nil
      @artist.add_song(self)
    end
    @artist
  end

  def artist
    @artist
  end

  def genre=(genre)
    if @genre == nil
      @genre = genre
    else
      @genre= @genre
    end
    if self.genre != nil
      @genre.add_song(self)
    end
    @genre

  end

  def genre
    @genre
  end

  def self.new_from_filename(filename) #creating a new instance of the song class from a given filename
    split_name = filename.gsub(/(\.mp3)/,'')
    #to convert the filename into a workable state where we can extract each element of the file 
    split_name = split_name.split(" - ")
    song = self.new(split_name[1])
    artist = Artist.find_or_create_by_name(split_name[0])
    genre = Genre.find_or_create_by_name(split_name[2])
    #setting the artist and genre relationship to this song
    song.artist = artist
    song.genre = genre
    song
  end 
  
  def self.create_from_filename(filename)
    @@all << new_from_filename(filename)
  end 
  
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end
  
end 