# encoding: UTF-8

require 'rufus/scheduler'

require_relative './orchestator.rb'

# Class in charge of calling the Orchestator periodically
# for him to start the news gathering
class Scheduler
  def initialize(interval = '2s')
    @scheduler = Rufus::Scheduler.new
    @scheduler.every interval do |job|
      puts 'Running: ' + job.id
      start_orchestator
    end
  end

  # Starts the Orchestator
  def start_orchestator
    Orchestator.instance.start
  end

  # Stop runing
  def stop
    @scheduler.shutdown
  end
end
