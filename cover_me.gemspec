# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cover_me}
  s.version = "0.0.1.20100813113452"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["markbates"]
  s.date = %q{2010-08-13}
  s.description = %q{cover_me was developed by: markbates}
  s.email = %q{mark+cover_me@markbates.com}
  s.extra_rdoc_files = ["README", "LICENSE"]
  s.files = ["lib/cover_me/config.rb", "lib/cover_me/formatter.rb", "lib/cover_me/hash.rb", "lib/cover_me/html_formatter.rb", "lib/cover_me/index.rb", "lib/cover_me/processor.rb", "lib/cover_me/report.rb", "lib/cover_me/templates/index.css", "lib/cover_me/templates/index.html.erb", "lib/cover_me/templates/jquery.js", "lib/cover_me/templates/jquery.tablesorter.js", "lib/cover_me/templates/report.css", "lib/cover_me/templates/report.html.erb", "lib/cover_me.rb", "README", "LICENSE"]
  s.homepage = %q{http://www.metabates.com}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{magrathea}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{cover_me}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
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
