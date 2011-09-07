require 'spec_helper'

describe CoverMe::Index do
  
  before(:each) do
    @bar_report = CoverMe::Report.new('/foo/bar.rb', [1, 0, nil, 24, nil, 1])
    @user_report = CoverMe::Report.new('/user.rb', [10, nil, nil, 69, nil, 1, 1, 1, 0, nil])
    @index = CoverMe::Index.new([@bar_report, @user_report])
  end
  
  describe "total_lines" do
    
    it "should sum up the total lines in the app" do
      @index.total_lines.should == 16
    end
    
  end
  
  describe "total_loc" do
    
    it "should sum up the total executable lines of code" do
      @index.total_loc.should == 10
    end
    
  end

  describe "total_untested_loc" do

    it "should sum up the total untested executable lines of code" do
      @index.total_untested_loc.should == 2
    end

  end

  describe "percent_tested" do
    
    it "should return the total percent tested" do
      @index.percent_tested.should == 80.0
    end
    
    it "should handle when there are no reports" do
      index = CoverMe::Index.new
      index.percent_tested.should == 0
    end
    
  end
  
end
