require 'rubygems'
require 'rake'
require 'rake/testtask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "libexcel"
    gem.summary = "A library that create Xml Excel documents"
    gem.description = "A library that create Xml Excel documents"
    gem.email = "silas.baronda@gmail.com"
    gem.homepage = "http:://github.com/silasb/libexcel"
    gem.authors = ["Silas Baronda"]
    gem.add_development_dependency "shoulda"
    gem.add_dependency('libxml-ruby', '>= 1.1.3')
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jewler (or a dependency) not available. Install it with: gem install jeweler"
end

desc "Run tests"
Rake::TestTask.new(:test) do |t|
  t.libs <<  'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

task :default => [:test]
