# encoding: utf-8

require 'sinatra'
configure { set :server, :puma }

# Main class
class Main < Sinatra::Base
  set :bind, '0.0.0.0'

  get '/' do
    'Hello world!'
  end
end
