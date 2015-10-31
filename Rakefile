# encoding: utf-8
require 'metric_fu'

task :default do
  puts 'TODO: configure crons'
end

MetricFu::Configuration.run do |config|
  config.configure_metric(:cane) do |cane|
    cane.enabled = true
    cane.abc_max = 15
    cane.line_length = 80
    cane.no_doc = 'y'
    cane.no_readme = 'y'
  end
end
