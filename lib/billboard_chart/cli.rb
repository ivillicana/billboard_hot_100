class BillboardChart::CLI

    # Main instance method
    def run
        main_menu
        select_song
        close_app
    end
    
    # list songs from scraper
    def main_menu
        puts "Welcome to the Billboard Hot 100 app:"
        puts "Which ranks would you like to see?"
        display_range
        select_range
        display_songs
    end

    #display and select range of songs
    def display_range
        i = 1
        r= 1
        10.times do
            puts "#{i}. Ranks #{r}-#{r+9}"
            i += 1
            r += 10
        end
    end

    def select_range
        puts "Enter the number of the range you would like to see?"
        input = gets.strip.downcase
        if input.to_i.between?(1, 10)
            create_songs(input.to_i)
        else
            puts "Please enter a valid value:"
            select_range
        end
    end

    #prints out 10 songs in selected range
    def display_songs
        
        puts ""
        @songs.each.with_index(1) do |song, i|
            puts "#{i}. #{song.title} - #{song.artist}"
        end
        puts ""
    end

    #create Song objects
    def create_songs(range)
        @songs = BillboardChart::Song.this_week(range)
    end

    # displays main menu
    def select_song
        input = nil
        while input != "exit"   
            puts "Please enter the song number to see more information:"
            puts "(You can also type 'exit' or 'main menu')"
            input = gets.strip.downcase

            #if/elseif/else depending on user input
            if input.to_i.between?(1, @songs.length)
                song = @songs[input.to_i - 1]
                song.print_info
            elsif input == "main menu"
                main_menu
            elsif input == "exit"
                break
            else
                puts "Please enter a valid value..."
            end
        end
    end

    # ends the application
    def close_app 
        puts "Thank you for using the Billboard Hot 100 CLI Application!"
    end
end