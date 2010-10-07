# http://engineering.attinteractive.com/2010/08/code-coverage-in-ruby-1-9/
require 'coverage'
require 'erb'
require 'fileutils'
require 'configatron'
require 'hashie'

module CoverMe
  
  class << self
    
    def complete!
      data_file = CoverMe.config.results.store

      if File.exists?(data_file)
        data = CoverMe::Results.read_results(data_file)

        CoverMe::Processor.new(data).process!
        CoverMe.config.at_exit.call
        
        File.delete(data_file)
      end
    end
    
  end
  
end

path = File.join(File.dirname(__FILE__), 'cover_me')

require File.expand_path(File.join(path, 'hash'))
require File.expand_path(File.join(path, 'config'))

CoverMe.set_defaults

%w{index report formatter processor html_formatter emma_formatter results directory_report global_report}.each do |file|
  require File.expand_path(File.join(path, file))
end

# Start the code coverage
Coverage.start

at_exit do
  CoverMe::Results.merge_results!(Coverage.result)
end