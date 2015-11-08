# encoding: UTF-8

require 'sinatra'
require 'sinatra/json'

require_relative './scheduler'

configure { set :server, :puma }

# Main class
class Main < Sinatra::Base
  _ = Scheduler.new

  get '/' do
    json status: 'on'
  end
end
