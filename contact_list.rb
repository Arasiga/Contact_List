require 'csv'
require 'pry'

class Contact

  attr_accessor :name, :email
  
  def initialize(name, email)
    
    @name = name
    @email = email
  end

  class << self

    def all 
      contacts = CSV.read('contacts.csv')
      contacts.map do |contact|
        contact[0].split(", ")
      end
    end

    def create(name, email)
      CSV.open("contacts.csv", "ab") do |csv|
        csv << ["#{name}, #{email}"]
      end
    end
    
    def find(id)
      
      if id > Contact.all.length
        "Sorry that ID does not exist"
      else
        "#{id}: #{Contact.all[id-1][0]}"
      end

    end
  
    def search(term)
    #binding.pry
  
     Contact.all.select do |x|
        (x[0].include?(term) || x[1].include?(term))
      end

    end

  end


end
