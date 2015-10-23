# encoding: utf-8

require 'sinatra'
require 'sinatra/json'
require 'rufus/scheduler'

configure { set :server, :puma }

# Main class
class Main < Sinatra::Base
  scheduler = Rufus::Scheduler.new

  get '/' do
    json status: 'on'
  end

  scheduler.every '1s' do
    puts 'rufus task'
  end
end
