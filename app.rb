require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'haml'
require 'json'
require 'httparty'

get '/styles.css' do
  scss :styles
end

get '/' do
  color = params[:color]
  palette = get_palette(color)
  haml :index, :locals => {:palette => palette}
end

def get_palette(hex)
  response = HTTParty.get("http://www.colourlovers.com/api/palettes/top?format=json&numResults=100&hex=#{hex}")
  response.sample['colors']
end