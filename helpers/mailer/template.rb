class Template
  def message(title, text)
    <<~MESSAGE_END
      From: <birotori@gmail.com>
      To: <birotori@gmail.com>
      MIME-Version: 1.0
      Content-type: text/html
      Subject: Un conte d'Esope

      <b>#{title}</b>
      <p>#{text}</p>
    MESSAGE_END
  end
end
