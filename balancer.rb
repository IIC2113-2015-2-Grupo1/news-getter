# Manaages the threads that gets fresh news
class Balancer

  # starts the thread pool. doesn't receive
  # no paramaters returns void
  def startThreads
  end

  # process a given strategy
  # receives a ProviderStrategy returns void
  def process(startegy)
  end

  # adds a strategy to the queue
  # receives a ProviderStrategy returns void
  def queue(strategy)
  end

  # verifies the current state of a thread
  # receives a Thread return a ThreadStatus
  def checkThreadStatus(thread)
  end

  # restarts a given thread
  # receives a Thread returns void
  def restartThread(thread)
  end

  # checks all threads
  # receives nothing returns void
  def monitorThreads
  end
end
