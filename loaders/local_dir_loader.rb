# encoding: UTF-8

require 'pathname'

require_relative './loader'

# Gathers the different ProviderStrategy's in order
# to give it to the Orchestator.
class LocalDirLoader < Loader
  DEFAULT_DIRECTORY = Pathname.new(__dir__) + '..' + 'providers' + 'lib'

  def initialize(directory = DEFAULT_DIRECTORY)
    @directory = directory
    @strategies = []
  end

  # Returns the different providers
  def providers
    before = ObjectSpace.each_object(Class).to_a
    filter_dir_contents(read_dir_contents).each { |f| require f }
    after = ObjectSpace.each_object(Class).to_a
    @strategies.concat((after - before).map(&:new))
  end

  # read directory contents
  protected def read_dir_contents
    Dir.entries(@directory).map { |e| @directory + e }
  end

  # return only ruby files
  protected def filter_dir_contents(array)
    array.select { |f| File.extname(f) == '.rb' }
  end
end
