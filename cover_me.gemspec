# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "cover_me"
  s.version = "1.2.0.20110907090445"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["markbates"]
  s.date = "2011-09-07"
  s.description = "CoverMe - Code Coverage for Ruby 1.9"
  s.email = "mark+cover_me@markbates.com"
  s.extra_rdoc_files = ["LICENSE"]
  s.files = ["lib/cover_me/config.rb", "lib/cover_me/directory_report.rb", "lib/cover_me/emma_formatter.rb", "lib/cover_me/formatter.rb", "lib/cover_me/global_report.rb", "lib/cover_me/hash.rb", "lib/cover_me/html_formatter.rb", "lib/cover_me/index.rb", "lib/cover_me/processor.rb", "lib/cover_me/report.rb", "lib/cover_me/results.rb", "lib/cover_me/templates/emma.xml.erb", "lib/cover_me/templates/index.css", "lib/cover_me/templates/index.html.erb", "lib/cover_me/templates/jquery.js", "lib/cover_me/templates/jquery.tablesorter.js", "lib/cover_me/templates/report.css", "lib/cover_me/templates/report.html.erb", "lib/cover_me.rb", "lib/generators/cover_me/install/install_generator.rb", "lib/generators/cover_me/install/templates/cover_me.rake", "LICENSE"]
  s.homepage = "http://www.metabates.com"
  s.post_install_message = "Thank you for installing CoverMe!\n\nUSAGE:\nAt the top of your 'test_helper.rb' or 'spec_helper.rb' place the following:\n\nrequire 'cover_me'\n\n!!! IT IS VERY IMPORTANT THAT THE REQUIRE STATEMENT BE THE VERY FIRST LINE OF THE FILE !!!\n\nRAILS 3:\nIf you are planning on using this with a Rails 3 project please run the following:\n\n$ rails g cover_me:install\n\nThis will install a Rake task to wrap your tests in CoverMe.\n"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")
  s.rubyforge_project = "magrathea"
  s.rubygems_version = "1.8.10"
  s.summary = "CoverMe - Code Coverage for Ruby 1.9"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<configatron>, [">= 0"])
      s.add_runtime_dependency(%q<hashie>, [">= 0"])
    else
      s.add_dependency(%q<configatron>, [">= 0"])
      s.add_dependency(%q<hashie>, [">= 0"])
    end
  else
    s.add_dependency(%q<configatron>, [">= 0"])
    s.add_dependency(%q<hashie>, [">= 0"])
  end
end
