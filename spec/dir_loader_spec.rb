# encoding: UTF-8

require_relative './spec_helper'
require_relative './../loaders/local_dir_loader'

describe 'local lib loader' do
  TEST_DIRECTORY = Pathname.new(__dir__) + 'lib'

  before :all do
    @loader = LocalDirLoader.new(TEST_DIRECTORY)
  end

  it 'should get files and filter from directory' do
    files = @loader.send(:read_dir_contents)
    expect(files).not_to be_empty
    expect(files.map { |f| f.basename.to_s }).to include('dummy.rb', 'text.txt')

    filtered = @loader.send(:filter_dir_contents, files)
    expect(filtered).not_to be_empty
    expect(filtered.map { |f| f.basename.to_s }).to contain_exactly('dummy.rb')
  end

  it 'should return strategies' do
    expect(@loader.providers).not_to be_empty
    @loader.providers.each do |provider|
      expect(provider).to be_a ProviderStrategy
    end
  end
end
