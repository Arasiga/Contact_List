require_relative 'contact_list'
require 'colorize'
require 'pry'

class ContactList


  def self.options(input)
    if input[0] == "list"
      Contact.all
    elsif input[0] == "menu"
      puts "Here is a list of available commands: \n\tnew - Create a new contact \n\tlist - List all contacts \n\tshow - Show a contact \n\tsearch - Search contacts \n\tupdate - update an existing contact"
    elsif input[0] == "new"
      puts "We will need your full name and your email:"
      print "name: "
      get_name = STDIN.gets.chomp.to_s
      print "email: "
      get_email = STDIN.gets.chomp.to_s

      Contact.create!(name: get_name, email: get_email)
      "Contact created!"

    elsif input[0] == "show"
      print "Please enter the ID number of the contact you wish to see:"
      number = STDIN.gets.chomp.to_i
      Contact.find(number)
    elsif input[0] == "search"
      print "Please enter a series of keywords you would like to search for : "
      characters = STDIN.gets.chomp.to_s
      #binding.pry
      Contact.where("email LIKE ? OR name LIKE ?", "%#{characters}%", "%#{characters}%")
    elsif input[0] == "update"  
      print "What is the id of the contact you wish to update?"
      name_id = STDIN.gets.chomp.to_i
      print "What is the updated name?"
      name_update = STDIN.gets.chomp.to_s
      print "What is the updated email?"
      email_update = STDIN.gets.chomp.to_s

      s = Contact.find(name_id)
      
      s.name = name_update
      s.email = email_update
      s.save
      "Contact updated!"
    elsif input[0] == "delete"
      print "What is the id of the contact you wish to delete?"
      id = STDIN.gets.chomp.to_i

      Contact.destroy(id)
    else
      "Error: that was not an option!"
     end
  
  end

end

pp ContactList.options(ARGV)






