require 'sinatra'
require 'omniauth'
require 'omniauth-github'
require 'octokit'
require 'haml'
require "sinatra/reloader" if development?

use Rack::Session::Cookie

configure do
  set :haml, :layout => :layout
end

set :session_secret, ENV['SESSION_SECRET'] || 'sssshhhh'

use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
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
  require_logon!
  haml :index
end

get '/slides/:id/' do
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
