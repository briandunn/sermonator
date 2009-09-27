# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sermonator}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brian Dunn"]
  s.date = %q{2009-09-27}
  s.default_executable = %q{sermonator}
  s.email = %q{brianpatrickdunn@gmail.com}
  s.executables = ["sermonator"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/sermonator",
     "lib/blog_client.rb",
     "lib/sermonator.rb",
     "lib/sermonator/application.rb",
     "lib/sermonator/options.rb",
     "lib/tcf.rb",
     "sermonator.gemspec",
     "test/sermonator_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/briandunn/sermonator}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A command line tool for publishing a raw audio file to a WordPress blog, with all kinds of settings hardcoded to be useful at my church.}
  s.test_files = [
    "test/sermonator_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
