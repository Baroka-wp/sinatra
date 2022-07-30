#!/usr/bin/env ruby
require 'sinatra'
require 'sinatra/flash'
require 'dotenv/load'
require './config/database'
require 'nokogiri'
require 'open-uri'
require 'net/smtp'
require 'json'

db = Database.new

get '/' do
  erb :index
end

get '/success' do
  erb :success
end

post '/' do
  @name = params['name']
  @email = params['email']
  @success = db.add_user(@name, @email)
  redirect '/success' if @success
  redirect '/'
end
