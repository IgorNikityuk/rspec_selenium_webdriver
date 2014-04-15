require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'
require 'selenium-webdriver'


############# ALL ############# 

desc "Run all tests"
# RUN ALL
RSpec::Core::RakeTask.new('all') do |t|
  t.rspec_opts = ["--format documentation","--color"]
  t.pattern = [
      'spec/*.rb'
  ]
end 
