require 'spec_helper'

describe CoverMe do
  
  describe "config" do
    
    it "should return the configatron.cover_me object" do
      CoverMe.config.should === configatron.cover_me
    end
    
    it "should allow settings to be set via a block" do
      configatron.temp do
        CoverMe.config.foo.should be_nil
        CoverMe.config do |c|
          c.foo = :bar
        end
        CoverMe.config.foo.should == :bar
      end
    end
    
  end
  
  describe "defaults" do
    
    describe "file_pattern" do
      
      it "should define a default file pattern to match" do
        File.join(CoverMe.config.project.root, 'lib/bar.rb').should match(CoverMe.config.file_pattern.last)
        File.join(CoverMe.config.project.root, 'app/models/user.rb').should match(CoverMe.config.file_pattern.first)
        File.join(CoverMe.config.project.root, 'other/foo.rb').should_not match(CoverMe.config.file_pattern.first)
        File.join(CoverMe.config.project.root, 'other/foo.rb').should_not match(CoverMe.config.file_pattern.last)
      end
      
    end
    
  end
  
end
