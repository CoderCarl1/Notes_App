require "tty-prompt"
require "tty-file"
require "tty-table"
require "csv"

# Display a start menu to user
class StartMenu 
    def initialize
        @start_prompt = TTY::Prompt.new
        @start_prompt.select("Create new noteboard or load existing one?") do |menu|
            menu.choice "New noteboard", -> {Noteboard.new}
            menu.choice "Load existing noteboard", -> {Noteboard.load_file}
            menu.choice "Exit", -> {system "clear"}
        end
    end  
    

end

class Noteboard
    #Creates a file for new noteboard
    def initialize
        puts "Enter a name for this new noteboard."
        file_name = gets.chomp
        @file = TTY::File.create_file "#{file_name}.csv", "#{file_name}"
        
        
        display_noteboard
    end
    
    #Finds any existing noteboard files and displays a selection menu
    def self.load_file
        @file_arr = Dir.glob("*csv")
        @file_menu = TTY::Prompt.new
        @file_menu.select("Select an existing noteboard") do |menu|
            for file in @file_arr do
            menu.choice "#{file}", -> {display_noteboard}
            end
            menu.choice "Back", -> {StartMenu.new}
        end
    end

    def display_noteboard
        CSV.read(@file)
    end

    # def alphabetical_sort

    # end
end

# class Notes < Noteboard
#     def add_note

#     end

#     def delete_note

#     end

#     def colour_code


#     end

# end

