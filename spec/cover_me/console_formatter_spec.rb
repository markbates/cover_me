require 'spec_helper'

describe CoverMe::ConsoleFormatter do

  before(:each) do
    @formatter = CoverMe::ConsoleFormatter.new
    $stdout = @output = StringIO.new
  end

  describe "format_report" do

    it "should exist" do
      @formatter.should respond_to(:format_report)
    end

  end

  describe "format_index" do

    it "should output to $stdout" do
      index = CoverMe::Index.new
      index.reports << CoverMe::Report.new(File.join(CoverMe.config.project.root, 'app', 'models', 'user.rb'), [1])
      @formatter.format(index)
      @output.string.length.should > 0
    end

  end

end
