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

    ### CLI Methods

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
            puts "#{index + 1}. #{ele.name}"
        end
    end

    def list_genres
        c = Genre.all.sort_by do |obj|
            obj.name
        end

        c.each_with_index do |ele, index|
            puts "#{index + 1}. #{ele.name}"
        end 
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        answer = gets.chomp
        
        ## prints all songs by a particular artist in a numbered list (alpha by song name)
        d = answer.sort_by do |obj|
            
            obj.name
        end 
        
        d.each_with_index do |ele, index|
            puts "#{index + 1}. #{ele.name} - #{ele.genre.name}"
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        gets.chomp
    end

    def play_song
        puts "Which song number would you like to play?"
        gets.chomp
    end


    ## CLI Triggers

end 
