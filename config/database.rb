require 'pg'
class Database
  def connect_db
    # con = PG.connect :host => 'ec2-34-197-84-74.compute-1.amazonaws.com', :dbname => 'd91lesarvph93b', :user => 'labkhwrfzqqeha', :password => '4b508c72fc8f1def7fe16155a36419a9b0080af65fba31db19a178e8b1c6ea27'
    con = PG.connect host: 'localhost', dbname: 'my_app', user: 'postgres'
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
