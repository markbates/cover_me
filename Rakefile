require 'rubygems'

# Set up gems listed in the Gemfile.
gemfile = File.expand_path('../Gemfile', __FILE__)
begin
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler'
  Bundler.setup
rescue Bundler::GemNotFound => e
  STDERR.puts e.message
  STDERR.puts "Try running `bundle install`."
  exit!
end if File.exist?(gemfile)

Bundler.require

Gemstub.test_framework = :rspec

Gemstub.gem_spec do |s|
  s.summary = 'CoverMe - Code Coverage for Ruby 1.9'
  s.description = s.summary
  s.version = '1.2.0'
  s.rubyforge_project = 'magrathea'
  s.add_dependency('configatron')
  s.add_dependency('hashie')
  s.email = 'mark+cover_me@markbates.com'
  s.homepage = 'http://www.metabates.com'
  s.required_ruby_version = '>= 1.9.2'
  s.post_install_message = <<-EOF
Thank you for installing CoverMe!

USAGE:
At the top of your 'test_helper.rb' or 'spec_helper.rb' place the following:

require 'cover_me'

!!! IT IS VERY IMPORTANT THAT THE REQUIRE STATEMENT BE THE VERY FIRST LINE OF THE FILE !!!

RAILS 3:
If you are planning on using this with a Rails 3 project please run the following:

$ rails g cover_me:install

This will install a Rake task to wrap your tests in CoverMe.
EOF
end

Gemstub.rdoc do |rd|
  rd.title = 'Cover Me - Code Coverage for Ruby 1.9'
end
