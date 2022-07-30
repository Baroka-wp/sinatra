require 'dotenv/load'
require './helpers/mailer/template'
class Mailer
  def send_mail(email, title, text)
    template = Template.new
    message = template.message(title, text)
    Net::SMTP.start('smtp.gmail.com', 587, 'localhost', 'birotori@gmail.com', ENV['MAILER_PWD'], :plain) do |smtp|
      smtp.send_message message, 'birotori@gmail.com', email
    end
  end
end
