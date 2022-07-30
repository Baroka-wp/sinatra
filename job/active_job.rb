require 'dotenv/load'
require 'net/smtp'
require './config/database'
require './helpers/mailer/mailer'

def job
  db = Database.new
  p users = db.get_users
  users.each do |user|
    fable = db.fables_data(user['conte_id'])[0]
    Mailer.new.send_mail(user['email'], fable['title'], fable['text'])
  end
  db.update_conte_id
end

job
