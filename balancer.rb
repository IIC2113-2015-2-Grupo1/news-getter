# Manaages the threads that gets fresh news
class Balancer
  # starts the thread pool
  def start_threads
  end

  # process a given strategy
  def process(startegy)
  end

  # adds a strategy to the queue
  def queue(strategy)
  end

  # verifies the current state of a thread
  def check_thread_status(thread)
  end

  # restarts a given thread
  def restart_thread(thread)
  end

  # checks all threads
  def monitor_threads
  end
end
