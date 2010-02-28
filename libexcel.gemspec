# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{libexcel}
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.5") if s.respond_to? :required_rubygems_version=
  s.authors = ["Silas Baronda"]
  s.date = %q{2010-02-27}
  s.email = ["silas.baronda@gmail.com"]
  s.files = ["lib/libexcel.rb", "lib/libexcel/worksheet.rb", "lib/libexcel/document.rb", "lib/libexcel/formula.rb"]
  s.homepage = %q{http://github.com/silasb/libexcel}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{XML Excel library for ruby}
  s.add_dependency("libxml")

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
