require 'pg'
class Database
  def connect_db
    con = PG.connect :host => 'ec2-107-22-122-106.compute-1.amazonaws.com', :dbname => 'd40dumovgahat', :user => 'ivdpyhkeyurlzw', :password => ENV['DATABASE_PWD']
    #con = PG.connect host: 'localhost', dbname: 'my_app', user: ENV['PG_PWD']
  end

  def fables_data(conte_id)
    con = connect_db
    fable = con.exec "SELECT * FROM fables WHERE id = #{conte_id}"
    fable.map { |row| row }
  rescue PG::Error => e
    puts e.message
  ensure
    con&.close
  end

  def get_users
    data = {}
    begin
      data = []
      con = connect_db
      users = con.exec 'SELECT * FROM users'
      users.each do |row|
        data << row
      end
      data
    rescue PG::Error => e
      puts e.message
    ensure
      con&.close
    end
  end

  def update_conte_id
    con = connect_db
    con.exec 'UPDATE users SET conte_id = conte_id + 1'
  rescue PG::Error => e
    puts e.message
  ensure
    con&.close
  end

  def add_user(name, email)
    con = connect_db
    con.exec "INSERT INTO users(full_name,email,conte_id) VALUES('#{name}','#{email}', 1)"
  rescue PG::Error => e
    puts e.message
  ensure
    con&.close
  end

  def add_fable(title, text)
    con = connect_db
    con.exec "INSERT INTO fables(title,text) VALUES('#{title}','#{text}')"
  rescue PG::Error => e
    puts e.message
  ensure
    con&.close
  end
end
