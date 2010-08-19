require 'rubygems'
require 'rspec'

require File.join(File.dirname(__FILE__), '..', 'lib', 'cover_me')

CoverMe.config do |c|
  c.at_exit = Proc.new {}
end

CoverMe.config.project.root = File.join(File.dirname(__FILE__), '..', 'fake_project')

Rspec.configure do |config|
  
  config.before(:all) do
    
  end
  
  config.after(:all) do
    
  end
  
  config.before(:each) do
    FileUtils.rm_rf(File.join(CoverMe.config.html_formatter.output_path))
  end
  
  config.after(:each) do
    FileUtils.rm_rf(File.join(CoverMe.config.html_formatter.output_path))
  end
  
end
