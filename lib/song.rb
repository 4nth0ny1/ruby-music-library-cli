require "pry"
class Song 
    attr_accessor :name, :artist
    attr_reader :genre

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
        songs = new(name)
        songs.save
        songs
    end

    ## Associations - Song and Artist 

    def artist=(artist)
        @artist = artist
        @artist.add_song(self)
    end

    ## Associations - Song and Genre 
    
    def genre=(genre)
        @genre = genre 
        a = @genre.songs
        if a.include?(self)  
        else    
            a << self
        end
    end

    ##Song
    
    def self.find_by_name(name)
        all.find { |a| a.name == name }
      end
  
    #   def self.find_or_create_by_name(name)
    #         find_by_name(name) || create(name)
    #   end 

      def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)
      end
    

      ## MusicImporter
      def self.new_from_filename(filename)
        parts = filename.split(" - ")
        artist_name, song_name, genre_name = parts[0], parts[1], parts[2].gsub(".mp3", "")

        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)

        new(song_name, artist, genre)
      end
  
      def self.create_from_filename(filename)
        new_from_filename(filename).tap {|s| s.save}
      end
end

class MusicImporter
    attr_accessor :song, :artist, :genre, :path

    def initialize(path)
        @path = path
    end

    def files
      Dir[@path+"/*.mp3"].map { |file| file.split("/").last }
    end
  
    def import
      files.each { |file| Song.new_by_filename(file) }
    end

    def self.import(list_of_filenames)
      list_of_filenames.each{ |filename| Song.new_by_filename(filename) }
    end
  end

  class MusicLibraryController 
    # extend MusicImporter
    def initialize(path)
        @path = path
        music_importer = MusicImporter.new(path)
    end



  end 

