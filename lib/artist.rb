require "pry"
class Artist 
    extend Concerns::Findable
    attr_accessor :name, :songs, :genre

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
        artist = self.new(name)
        artist.save
        artist
    end

    ## Associations - Song and Artist 

    def songs 
        @songs 
    end 

    def add_song(song)
        if song.artist != self
            @songs << song 
            song.artist = self
        end
    end

    ## Associations - Artist and Genre

    def songs_array 
        Song.all.select do |song|
            song.artist == self 
        end 
    end 

    # def genres   
    #     binding.pry
    #     songs_array.map do |song|
    #         if song.genre != self
    #             song.genre   
    #         end
    #     end
    # end

    def genres
        songs_array.collect{ |s| s.genre }.uniq
      end
    

end