$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require 'rubygems'
require 'rake'
require 'rake/testtask'

require 'libexcel'

desc "Run tests"
Rake::TestTask.new(:test) do |t|
  t.libs <<  'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc "install the gem locally"
task :install => :package do
  sh %{gem install pkg/#{spec.name}-#{spec.version}}
end

task :default => [:test]
