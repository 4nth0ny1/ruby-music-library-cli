class Artist 
    attr_accessor :name, :songs

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


end