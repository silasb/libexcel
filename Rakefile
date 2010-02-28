$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require 'rubygems'
require 'rubygems/specification'
require 'rake'
require 'rake/testtask'

require 'libexcel'

spec = Gem::Specification.new do |s|
  s.name     = "libexcel"
  s.version  = LibExcel::VERSION
  s.authors  = ["Silas Baronda"]
  s.email    = ["silas.baronda@gmail.com"]
  s.homepage = "http://github.com/silasb/libexcel"
  s.summary  = "XML Excel library for ruby"

  s.platform = Gem::Platform::RUBY
  s.required_rubygems_version = ">= 1.3.5"

  s.files = Dir.glob("{lib}/**/*")
  s.require_path = 'lib'
end

Rake::TestTask.new(:test) do |t|
  t.libs <<  'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

begin
  require 'rake/gempackagetask'
rescue LoadError
  task(:gem) { $stderr.puts '`gem install rake` to package gem' }
else
  Rake::GemPackageTask.new(spec) do |pkg|
    pkg.gem_spec = spec
  end
  task :gem => :gemspec
end

desc "install the gem locally"
task :install => :package do
  sh %{gem install pkg/#{spec.name}-#{spec.version}}
end

desc "create a gemspec file"
task :gemspec do
  File.open("#{spec.name}.gemspec", "w") do |f|
    f.puts spec.to_ruby
  end
end

task :package => :gemspec
task :default => [:test]
