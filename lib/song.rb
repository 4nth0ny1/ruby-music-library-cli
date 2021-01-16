class Song 
    attr_accessor :name, :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name 
        save
        if artist != nil
            self.artist = artist 
        end
        if genre != nil 
            self.genre = genre
        end
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
        songs = self.new(name)
        songs.save
        songs
    end

    ## Associations - Song and Artist 

    def artist=(artist)
        @artist = artist
        @artist.add_song(self)
    end

    # def genre=(genre)
    #     @genre = genre 
    #     @genre.add_song(self)
    # end
  

end 
