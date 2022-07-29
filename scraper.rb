require './config/database'
require 'nokogiri'
require 'open-uri'

class Scraper
  def initialize
    @db = Database.new
  end

  def save_in_db(title, text)
    @db.add_fable(title, text)
  end

  def save_data(data)
    File.open('text.json', 'a') do |f|
      f.write(data.to_json)
    end
  end

  def all
    data = []
    file = File.open('text.json')
    file.read.each do |d|
      data << d
    end
    data
  end

  def get_next_url(uri)
    document = Nokogiri::HTML.parse(URI.open(uri).read)
    root = 'https://fr.wikisource.org'
    next_link = root + document.css('div#subheader a')[1]['href']
  end

  def getFable(uri, n = 0)
    return if n > 357

    document = Nokogiri::HTML.parse(URI.open(uri).read)
    tags = document.xpath('//p')
    p title = document.css('h1#firstHeading').text.split('/')[1]
    text = ''
    tags.each do |tag|
      text += tag.text.to_s unless tag == tags.first
    end

    next_link = get_next_url(uri)
    n += 1
    save_in_db(title, text)
    getFable(next_link, n)
  end
end

s = Scraper.new
first_uri = 'https://fr.wikisource.org/wiki/Fables_d%E2%80%99%C3%89sope_(trad._Chambry,_1927)/Les_Biens_et_les_Maux'

s.getFable(first_uri)
