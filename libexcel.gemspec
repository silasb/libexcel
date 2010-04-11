# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "libexcel"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Silas Baronda"]
  s.email = ["silas.baronda@gmail.com"]
  s.date = %q{2010-02-28}
  s.description = "A library that create Xml Excel documents"
  s.summary = "A library that create Xml Excel documents"
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".autotest",
     ".gitignore",
     "README.rdoc",
     "Rakefile",
     "lib/libexcel.rb",
     "lib/libexcel/document.rb",
     "lib/libexcel/formula.rb",
     "lib/libexcel/worksheet.rb",
     "libexcel.gemspec",
     "test/document_test.rb",
     "test/excel_test.rb",
     "test/formula_test.rb",
     "test/helper.rb",
     "test/worksheet_test.rb"
  ]
  s.homepage = %q{http://github.com/silasb/libexcel}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.test_files = [
    "test/document_test.rb",
     "test/helper.rb",
     "test/excel_test.rb",
     "test/worksheet_test.rb",
     "test/formula_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_runtime_dependency(%q<libxml-ruby>, [">= 1.1.3"])
    else
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<libxml-ruby>, [">= 1.1.3"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<libxml-ruby>, [">= 1.1.3"])
  end
end

