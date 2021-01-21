class Genre 
    extend Concerns::Findable
    attr_accessor :name, :songs, :artist

    @@all = []

    def initialize(name)
        @name = name 
        save
        @songs = []
    end 

    def self.all 
        @@all
    end 
    
    def self.destroy_all
        @@all.clear
    end 

    def save 
        @@all << self
    end 


    def self.create(name)
        new_genre = Genre.new(name)
        @@all << self
        new_genre
    end

    ## Associations - Song and Genre 

    def songs 
        @songs 
    end 

    ## Associations - Artist and Genre 

    def artists
        songs.collect{ |s| s.artist }.uniq
      end
    
end