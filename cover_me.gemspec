# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cover_me}
  s.version = "1.0.0.20110525205338"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{markbates}]
  s.date = %q{2011-05-26}
  s.description = %q{CoverMe - Code Coverage for Ruby 1.9}
  s.email = %q{mark+cover_me@markbates.com}
  s.extra_rdoc_files = [%q{LICENSE}]
  s.files = [%q{lib/cover_me/config.rb}, %q{lib/cover_me/directory_report.rb}, %q{lib/cover_me/emma_formatter.rb}, %q{lib/cover_me/formatter.rb}, %q{lib/cover_me/global_report.rb}, %q{lib/cover_me/hash.rb}, %q{lib/cover_me/html_formatter.rb}, %q{lib/cover_me/index.rb}, %q{lib/cover_me/processor.rb}, %q{lib/cover_me/report.rb}, %q{lib/cover_me/results.rb}, %q{lib/cover_me/templates/emma.xml.erb}, %q{lib/cover_me/templates/index.css}, %q{lib/cover_me/templates/index.html.erb}, %q{lib/cover_me/templates/jquery.js}, %q{lib/cover_me/templates/jquery.tablesorter.js}, %q{lib/cover_me/templates/report.css}, %q{lib/cover_me/templates/report.html.erb}, %q{lib/cover_me.rb}, %q{lib/generators/cover_me/install/install_generator.rb}, %q{lib/generators/cover_me/install/templates/cover_me.rake}, %q{LICENSE}]
  s.homepage = %q{http://www.metabates.com}
  s.post_install_message = %q{Thank you for installing CoverMe!

USAGE:
At the top of your 'test_helper.rb' or 'spec_helper.rb' place the following:

require 'cover_me'

!!! IT IS VERY IMPORTANT THAT THE REQUIRE STATEMENT BE THE VERY FIRST LINE OF THE FILE !!!

RAILS 3:
If you are planning on using this with a Rails 3 project please run the following:

$ rails g cover_me:install

This will install a Rake task to wrap your tests in CoverMe.
}
  s.require_paths = [%q{lib}]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")
  s.rubyforge_project = %q{magrathea}
  s.rubygems_version = %q{1.8.2}
  s.summary = %q{CoverMe - Code Coverage for Ruby 1.9}

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
