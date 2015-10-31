# encoding: UTF-8

require_relative './spec_helper'
require_relative './../scheduler'

describe 'scheduler' do
  it 'should start orchestator at time interval' do
    counter = 0
    expect_any_instance_of(Scheduler).to receive(:start_orchestator)
      .and_return(counter += 1)

    _ = Scheduler.new('1s')

    sleep 2
    expect(counter).to_not equal(0)
  end
end
