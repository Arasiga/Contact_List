require_relative 'contact_list'
require 'colorize'
require 'pry'
require 'csv'


class ContactList


  def self.options(input)
    if input[0] == "list"
      Contact.all.each_with_index do |x, index|
        puts "#{index+1}: #{x[0]}, #{x[1]}"
      end
    elsif input[0] == "menu"
      puts "Here is a list of available commands: \n\tnew - Create a new contact \n\tlist - List all contacts \n\tshow - Show a contact \n\tsearch - Search contacts"
      
    elsif input[0] == "new"
      puts "We will need your full name and your email:"
      print "name: "
      get_name = STDIN.gets.chomp.to_s
      print "email: "
      get_email = STDIN.gets.chomp.to_s


     z = false

      Contact.all.each do |x|
        if x[1].include?(get_email) == true
          z = true
        end
      end

      if z
        puts "Sorry that email already exists!"
      else
        Contact.create(get_name, get_email)
        puts "Contact created!"
      end
     elsif input[0] == "show"
      print "Please enter the ID number of the contact you wish to see:"
      number = STDIN.gets.chomp.to_i
      puts Contact.find(number)
    elsif input[0] == "search"
      print "Please enter a series of keywords you would like to search for : "
      characters = STDIN.gets.chomp.to_s
      if Contact.search(characters) != nil
        puts "#{Contact.search(characters)[0]}, #{Contact.search(characters)[1]}"
      else
        puts "Sorry those set of characters do not appear in the contact list"
      end      
    else
      "Error: that was not an option!"
     end
  
  end

end

ContactList.options(ARGV)






