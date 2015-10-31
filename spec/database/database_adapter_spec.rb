# encoding: UTF-8
# IMPORTANT: to run the test you need the correct ENV variables set
require_relative './../spec_helper'
require_relative './../../database/database_adapter'

describe 'database adapter' do
  before :all do
    @adapter = DatabaseAdapter.new
  end

  it 'should not let you save news without basic attributes' do
    hash = { 'title' => 'IMPORTANT' }
    response = @adapter.save(hash)
    expect(response).to be false
    hash['body'] = 'somewhere'
    response = @adapter.save(hash)
    expect(response).to be false
    hash['image'] = 'the body is here'
    hash['url'] = 'kfokfo'
    response = @adapter.save(hash)
    expect(response).to be true
  end
end
