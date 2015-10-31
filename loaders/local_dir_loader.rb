# encoding: UTF-8

require 'pathname'

require_relative './loader'

# Gathers the different ProviderStrategy's in order
# to give it to the Orchestator.
class LocalDirLoader < Loader
  def initialize
    @strategies = []
  end

  # Returns the different providers
  def providers
    before = ObjectSpace.each_object(Class).to_a
    filter_dir_contents(read_dir_contents).each { |f| require f }
    after = ObjectSpace.each_object(Class).to_a
    @strategies.concat((after - before).map(&:new))
  end

  # lib path
  protected def dir_path
    Pathname.new(__dir__) + '..' + 'providers' + 'lib'
  end

  # read directory contents
  protected def read_dir_contents
    Dir.entries(dir_path).map { |e| dir_path + e }
  end

  # return only ruby files
  protected def filter_dir_contents(array)
    array.select { |f| File.extname(f) == '.rb' }
  end
end
