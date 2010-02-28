Gem::Specification.new do |s|
  s.name = "libexcel"
  s.summary = "XML Excel library for ruby"
  s.homepage = "http://github.com/silasb/libexcel"

  s.authors = ["Silas Baronda"]
  s.email = ["silas.baronda@gmail.com"]

  s.date = "2010-02-27"
  s.version = "0.1"

  s.files = Dir["lib/**/*"]
  s.require_paths = ["lib"]

  s.add_dependency "libxml-ruby", ">= 1.1.3"

  s.has_rdoc = true

  s.rubygems_version = "1.3.6"
  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.5")
end
