require 'spec_helper'

describe CoverMe::HtmlFormatter do
  
  before(:each) do
    @formatter = CoverMe::HtmlFormatter.new
    FileUtils.rm_rf(File.join(CoverMe.config.html_formatter.output_path))
  end
  
  after(:each) do
    FileUtils.rm_rf(File.join(CoverMe.config.html_formatter.output_path))
  end
  
  describe "format_report" do
    
    it "should generate HTML for a report" do
      report = CoverMe::Report.new(File.join(CoverMe.config.project.root, 'app', 'models', 'user.rb'), [1])
      @formatter.format(report)
      File.exists?(File.join(CoverMe.config.html_formatter.output_path, 'app', 'models', 'user.rb.html')).should be_true
    end
    
  end
  
  describe "format_index" do
    
    it "should generate HTML for a report" do
      index = CoverMe::Index.new
      index.reports << CoverMe::Report.new(File.join(CoverMe.config.project.root, 'app', 'models', 'user.rb'), [1])
      @formatter.format(index)
      File.exists?(File.join(CoverMe.config.html_formatter.output_path, 'index.html')).should be_true
    end
    
  end
  
  describe "finalize" do
    
    it "should finalize the formatter and dump out any last files" do
      @formatter.finalize
      CoverMe.config.html_formatter.finalizer_files.each do |name, template|
        File.exists?(File.join(CoverMe.config.html_formatter.output_path, name)).should be_true
      end
    end
    
  end
  
end
