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
  s.version = '1.0.0.pre4'
  s.rubyforge_project = 'magrathea'
  s.add_dependency('configatron')
  s.add_dependency('hashie')
  s.email = 'mark+cover_me@markbates.com'
  s.homepage = 'http://www.metabates.com'
end

Gemstub.rdoc do |rd|
  rd.title = 'Cover Me - Code Coverage for Ruby 1.9'
end
