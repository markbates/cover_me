require 'rubygems'
require 'rspec'

require File.join(File.dirname(__FILE__), '..', 'lib', 'cover_me')

CoverMe.config.project.root = File.join(File.dirname(__FILE__), '..', 'fake_project')

Rspec.configure do |config|
  
  config.before(:all) do
    
  end
  
  config.after(:all) do
    
  end
  
  config.before(:each) do
    
  end
  
  config.after(:each) do
    
  end
  
end
