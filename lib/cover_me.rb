# http://engineering.attinteractive.com/2010/08/code-coverage-in-ruby-1-9/

require 'coverage'
require 'erb'
require 'fileutils'
require 'configatron'

module CoverMe
end

path = File.join(File.dirname(__FILE__), 'cover_me')

require File.expand_path(File.join(path, 'hash'))
require File.expand_path(File.join(path, 'config'))

CoverMe.set_defaults

%w{index report formatter processor html_formatter}.each do |file|
  require File.expand_path(File.join(path, file))
end

# Start the code coverage
# if ENV['use_coverage']
  Coverage.start

  at_exit do
    CoverMe::Processor.new(Coverage.result).process!
    CoverMe.config.at_exit.call
  end
# end