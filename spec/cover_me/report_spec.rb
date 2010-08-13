require 'spec_helper'

describe CoverMe::Report do
  
  before(:each) do
    @report = CoverMe::Report.new(File.join(CoverMe.config.project.root, '/lib/foo/bar.rb'), [1, 0, nil, 24, nil, 1])
  end
  
  describe "initialize" do
    
    it "should clean up the file name" do
      r = CoverMe::Report.new('/foo/bar.rb')
      r.filename.should == 'foo/bar.rb'
      
      r = CoverMe::Report.new('foo/bar.rb')
      r.filename.should == 'foo/bar.rb'
    end
    
    it "should set the lines attribute" do
      @report.lines.should == 6
    end
    
    it "should set the lines of code attribute" do
      @report.lines_of_code.should == 4
    end
    
    it "should set the executed_percent attribute" do
      @report.executed_percent.should == 75.0
    end
    
    it "should set the failed passed attribute" do
      @report.unexecuted_percent.should == 25.0
    end
    
  end
  
  describe "proximity" do
    
    it "should report the proximity to 100%" do
      @report.stub!(:executed_percent).and_return(100)
      @report.proximity.should == 'hit'
      
      @report.instance_variable_set('@proximity', nil)
      
      @report.stub!(:executed_percent).and_return(90)
      @report.proximity.should == 'near'
      
      @report.instance_variable_set('@proximity', nil)
      
      @report.stub!(:executed_percent).and_return(89)
      @report.proximity.should == 'miss'
    end
    
  end
  
  describe "hit_type" do
    
    it "should return a hit type based on the coverage count" do
      @report.hit_type(nil).should == 'never'
      @report.hit_type(0).should == 'miss'
      @report.hit_type(1).should == 'hit'
    end
    
  end
  
  describe "<=>" do
    
    it "should sort the reports" do
      r1 = CoverMe::Report.new('/foo/bar.rb')
      r2 = CoverMe::Report.new('/bar/foo.rb')
      r3 = CoverMe::Report.new('/fubar.rb')
      [r1, r2, r3].sort.should == [r2, r1, r3]
    end
    
  end
  
  describe "source" do
    
    it "should return the source of the file" do
      @report.source.should == ['I am bar.rb!']
    end
    
  end
  
  describe "test_file_name" do
    
    it "should return the test file name for specs" do
      r = CoverMe::Report.new('foo.rb')
      r.test_file_name.should == File.join(CoverMe.config.project.root, 'spec', "foo_spec.rb")
    end
    
    it "should return the test file name for test/unit" do
      r = CoverMe::Report.new('bar.rb')
      r.test_file_name.should == File.join(CoverMe.config.project.root, 'test', "bar_test.rb")
    end
    
    it "should return nil if there is no test" do
      r = CoverMe::Report.new('idontexist.rb')
      r.test_file_name.should be_nil
    end
    
  end
  
  describe "test_file" do
    
    it "should read the file for a spec" do
      r = CoverMe::Report.new('foo.rb')
      r.test_file.should == 'Hello from Foo Spec!'
    end
    
    it "should read the file for a test" do
      r = CoverMe::Report.new('bar.rb')
      r.test_file.should == 'Hello from Bar Test!'
    end
    
    it "should return nil if there is no file" do
      r = CoverMe::Report.new('idontexist.rb')
      r.test_file.should be_nil
    end
    
  end
  
  describe "short_test_file_name" do
    
    it "should return the short name for a spec" do
      r = CoverMe::Report.new('foo.rb')
      r.short_test_file_name.should == 'spec/foo_spec.rb'
    end
    
    it "should return the short name for a test" do
      r = CoverMe::Report.new('bar.rb')
      r.short_test_file_name.should == 'test/bar_test.rb'
    end
    
  end
  
end
