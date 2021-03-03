require 'pry'
class Artist 
  extend Concerns::Findable
  extend Persistable::ClassMethods 
  include Persistable::InstanceMethods
  attr_accessor :name, :songs
  @@all = [] 
  
  def initialize(name)
    @name = name 
    save
    @songs = []
  end 
  
  #def save 
   # @@all << self 
  #end 
  
  def self.all 
    @@all 
  end 

  def add_song(song)
    song.artist = self unless song.artist == self
    @songs << song unless @songs.include?(song)
  end
  
  def genres 
    genres = @songs.collect do |song|
      song.genre 
    end 
    genres.uniq 
  end
  
  def songs 
    @songs
  end 
  
 # def self.find_by_name(name)
  #  @@all.detect{|artist| artist.name == name}
  #end 
  
end 