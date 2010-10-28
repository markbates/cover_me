require 'spec_helper'

describe CoverMe::Processor do
  
  before(:each) do
    @formatter = CoverMe::HtmlFormatter.new
    @processor = CoverMe::Processor.new({
      File.join(CoverMe.config.project.root, 'lib/foo/bar.rb') => [1, 0, nil, 69, 10, nil, 3],
      File.join(CoverMe.config.project.root, 'app/models/user.rb') => [0, 0, 20, 1, 0, nil, 30, nil, 12],
      File.join(CoverMe.config.project.root, 'other/foo.rb') => [1, 2, 3, 4]
    }, :formatter => @formatter)
  end
  
  describe "process!" do
    
    it "should process the results of the coverage" do
      @formatter.should_receive(:format_report).twice
      @formatter.should_receive(:format_index).once
      @processor.process!
      @processor.index.should_not be_nil
      @processor.index.reports.size.should == 2
    end
    
  end
  
end
