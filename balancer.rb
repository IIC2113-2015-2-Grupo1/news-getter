# encoding: UTF-8

require 'concurrent'
require 'thread'

# Manaages the threads that gets fresh news
class Balancer
  def initialize
    @work_queue = Queue.new
    @pool = start_threads
  end

  # starts the thread pool. doesn't receive
  # no paramaters returns void
  def start_threads
    8.times.map do
      Thread.new do
        loop do
          strategy = @work_queue.pop
          begin
            strategy.run(DateTime.now)
          rescue
            puts 'thread error'
          end
        end
      end
    end
  end

  # process a given strategy
  # receives a ProviderStrategy returns void
  def process(strategy)
    # TODO: process, change DateTime
    puts 'process', strategy, '-----'
    strategy.run(DateTime.now)
  end

  # adds a strategy to the queue
  # receives a ProviderStrategy returns void
  def queue(strategy)
    @work_queue.push(strategy)
  end

  # restarts a given thread
  # receives a Thread returns void
  def restart_thread(thread)
    @pool.wait_for_termination
    start_threads
  end
end
