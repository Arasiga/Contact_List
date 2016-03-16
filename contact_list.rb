require 'pry'
require 'pg'

class Contact

  attr_accessor :name, :email
  
  def initialize(name, email)
    
    @name = name
    @email = email
  end

  class << self

    def connection(string, *value)
      conn = PG.connect(
        host: 'localhost',
        dbname: 'contact',
        user: 'development',
        password: 'development'
      )
      res = conn.exec(string, value)
      conn.close
      res
    end

    def all 
      result = connection('SELECT * FROM contacts;')
      result.to_a
    end

   def save(name, email)
      result = connection('INSERT INTO contacts (name, email) VALUES($1, $2)', name, email)
   end  
    
    def find(id)
      result = connection('SELECT * FROM contacts WHERE id = $1::int', id)
      result.to_a
    end
  
    def search(term)      
      result = connection('SELECT * FROM contacts WHERE UPPER(name) LIKE UPPER($1) OR UPPER(name) LIKE UPPER($1)', '%'+term+'%') 
      result.to_a                
    end

    def update(name, email, name_id)
      the_contact = Contact.find(name_id)
      number = the_contact[0]["id"].to_i
      result = connection('UPDATE contacts SET name = $1, email = $2 WHERE id = $3', name, email, name_id)
    end

    def delete(id)
      connection('DELETE FROM contacts WHERE id = $1;', id)
    end

  end
end







