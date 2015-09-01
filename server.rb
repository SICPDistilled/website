require 'sinatra'
require 'haml'
require 'redcarpet'
require 'sinatra/reloader' if development?

Tilt.register Tilt::RedcarpetTemplate::Redcarpet2, 'markdown', 'mkd', 'md'

set :markdown, :fenced_code_blocks => true,
               :layout_engine => :haml,
               :layout => :layout,
               :no_intra_emphasis => true

configure do
  set :haml, :layout => :layout
end

configure :production do
  require 'newrelic_rpm'
end

set :session_secret, ENV['SESSION_SECRET'] || 'sssshhhh'

def environment
  ENV['RACK_ENV']
end

before do
  if environment == 'production'
    cache_control :public, :max_age => 600
  end
end

get '/' do
  redirect '/section/1-distilled'
end

not_found do
  markdown :not_found
end

get '/section/:id' do
  id = params[:id]
  if File.file?(File.join(File.dirname(__FILE__), 'views', 'section', "#{id}.md"))
    markdown "/section/#{id}".to_sym
  else
    markdown :coming_soon
  end
end

get '/slides/:id/' do
  @id = params[:id]
  erb :presentation
end
