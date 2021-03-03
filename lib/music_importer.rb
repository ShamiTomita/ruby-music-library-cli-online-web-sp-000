require 'pry'
class MusicImporter
  
  attr_accessor :path
  
  @@all = []
  
  def initialize(path)
    @path = path
    @@all << self
  end
  
 
  
  def files #creates a file from the directory of files
    files = Dir.glob("#{path}**/*")
    #returns the files that are mp3s
		files = files.collect{|file|file.scan(/(?<=mp3s\/)(.*)/)}.flatten 
    
  end 
  
  def import #takes in the files that we have just created access to so that we can make them into new songs
	    newfile = self.files
		  newfile.each do |file|
		    new_song = Song.create_from_filename(file)
		  end
	end
    
end 