# encoding: UTF-8

require 'concurrent'

# Manaages the threads that gets fresh news
class Balancer
  def initialize
    @work_queue = Queue.new
    @pool = Concurrent::CachedThreadPool.new
    start_threads
  end

  # starts the thread pool. doesn't receive
  # no paramaters returns void
  def start_threads
    # TODO: check if this is correct
    @pool.post do
      loop do
        process(@work_queue.pop)
      end
    end
  end

  # process a given strategy
  # receives a ProviderStrategy returns void
  def process(strategy)
    # TODO: process, change DateTime
    strategy.run(DateTime.now)
  end

  # adds a strategy to the queue
  # receives a ProviderStrategy returns void
  def queue(strategy)
    @work_queue << strategy
  end

  # restarts a given thread
  # receives a Thread returns void
  def restart_thread(thread)
    @pool.wait_for_termination
    start_threads
  end
end
