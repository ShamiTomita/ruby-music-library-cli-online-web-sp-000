class Genre 
  extend Concerns::Findable
  extend Persistable::ClassMethods 
  include Persistable::InstanceMethods
  attr_accessor :name, :song
  @@all = [] 
  def initialize(name)
    @name = name 
    @songs = []
    save 
  end 
  
  #def save 
   # @@all << self 
 # end 
  
  def self.all 
    @@all 
  end 
  
 #def self.destroy_all
  #  @@all.clear
  #end 
  
 #def self.create(name)
  #  genre = Genre.new(name)
   # self.all << genre
    #genre
#  end 
  
  def artists 
    artists = @songs.collect do |song|
      song.artist 
    end 
    artists.uniq 
  end
  
  def songs
    @songs
  end 
  
  def add_song(song)
    song.genre = self unless song.genre == self
    @songs << song unless @songs.include?(song)
  end
end 