require "pry"
class Song 
    attr_accessor :name, :artist
    attr_reader :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name 
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
        self.class.all << self
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
        genre.songs << self unless genre.songs.include?(self)
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
      files.each { |file| Song.create_from_filename(file) }
    end
  end

  class MusicLibraryController 

    attr_accessor :path, :artist

    def initialize(path = './db/mp3s')
        @path = path
        music_importer = MusicImporter.new(path)
        music_importer.import
        @artist = artist
    end

    def call 
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        gets.chomp
        if gets.chomp != "exit"
            call
        end
    end

    def list_songs
        a = Song.all.sort_by do |obj| 
            obj.name 
        end

        a.each_with_index do |ele, index| 
            puts "#{index + 1}. #{ele.artist.name} - #{ele.name} - #{ele.genre.name}"
        end
    end

    def list_artists
        b = Artist.all.sort_by do |obj|
            obj.name
        end

        b.each_with_index do |ele, index|      
            puts "#{index + 1}. #{ele.artist} - #{ele.song.name} - #{ele.genre.name}"
        end
    end



end 

