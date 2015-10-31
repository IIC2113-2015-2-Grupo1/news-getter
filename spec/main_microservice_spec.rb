# encoding: UTF-8

require_relative './spec_helper'
require_relative './../main'

describe 'Sinatra Application' do
  include Rack::Test::Methods

  def app
    Main
  end

  it 'should allow accessing the home page' do
    get '/'
    expect(last_response).to be_ok
  end
end
