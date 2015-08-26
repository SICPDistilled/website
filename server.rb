require 'sinatra'
require 'omniauth'
require 'omniauth-github'
require 'octokit'
require 'haml'
require 'redcarpet'
require 'sinatra/reloader' if development?

use Rack::Session::Cookie

Tilt.register Tilt::RedcarpetTemplate::Redcarpet2, 'markdown', 'mkd', 'md'

set :markdown, :fenced_code_blocks => true,
               :layout_engine => :haml,
               :layout => :layout

configure do
  set :haml, :layout => :layout
end

configure :production do
  require 'newrelic_rpm'
end

set :session_secret, ENV['SESSION_SECRET'] || 'sssshhhh'

use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
end

def environment
  ENV['RACK_ENV']
end

def github
  @github ||= Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
end

def authenticated?
  return true if settings.development?
  session[:authenticated] && in_org?(session[:user_id])
end

def in_org?(id)
  github.organization_member?('SICPDistilled', id)
end

def require_logon!
  redirect '/sign-in' unless authenticated?
end

get '/sign-in' do
  haml :sign_in
end

get '/' do
  redirect '/section/1-intro'
end

not_found do
  markdown :not_found
end

get '/section/:id' do
  require_logon!
  id = params[:id]
  if File.file?(File.join(File.dirname(__FILE__), 'views', 'section', "#{id}.md"))
    markdown "/section/#{id}".to_sym
  else
    markdown :coming_soon
  end
end

get '/slides/:id/' do
  require_logon!
  @id = params[:id]
  erb :presentation
end

get '/auth/:provider/callback' do
  session[:authenticated] = true
  session[:user_id] = request.env['omniauth.auth']['info']['nickname']
  redirect '/'
end

get '/auth/failure' do
  haml :auth_failed
end

get '/auth/:provider/deauthorized' do
  haml :deauthorized
end

get '/logout' do
  session[:authenticated] = false
  redirect '/'
end
