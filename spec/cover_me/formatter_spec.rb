require 'spec_helper'

describe CoverMe::Formatter do
  
  before(:each) do
    @formatter = CoverMe::Formatter.new
  end
  
  describe "format" do
    
    it "should call the appropriate method for the object" do
      lambda {@formatter.format(CoverMe::Report.new('foo.rb'))}.should raise_error(NoMethodError, /format_report/)
      lambda {@formatter.format(CoverMe::Index.new)}.should raise_error(NoMethodError, /format_index/)
    end
    
  end
  
  describe "template" do
    
    it "should return an ERB template for a file" do
      @formatter.template('index.html.erb').should be_kind_of(ERB)
    end
    
    it "should receive trim_mode as second argument" do
      lambda {@formatter.template('console.erb', '-')}.should_not raise_error
    end
    
  end
  
end
