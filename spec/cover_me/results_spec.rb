require 'spec_helper'

describe CoverMe::Results do
  
  before(:each) do
    @idontexist_path = File.join(CoverMe.config.project.root, 'idontexist.data')
    
    res = {'file1' => [0, nil, 1],
           'file2' => [nil, 1, nil]}
    File.open(CoverMe.config.results.store, 'w') do |f|
      f.write(res.inspect)
    end
  end
  
  after(:each) do
    [CoverMe.config.results.store, @idontexist_path].each do |file|
      File.delete(file) if File.exists?(file)
    end
  end
  
  describe "read_results" do
    
    it "should return results as a Hash from the file" do
      res = CoverMe::Results.read_results
      res.should be_kind_of(Hash)
      res.should_not be_empty
    end
    
    it "should return empty results if there aren't any" do
      res = CoverMe::Results.read_results(@idontexist_path)
      res.should be_kind_of(Hash)
      res.should be_empty
    end

    it "should return empty results if reading the file fails with a Syntax error" do
      File.stub!(:read).and_return('{garbage}')
      res = CoverMe::Results.read_results
      res.should be_kind_of(Hash)
      res.should be_empty
    end

  end
  
  describe "merge_results!" do
    
    before(:each) do
      @more_results = {'file1' => [nil, 1, 1],
                       'file2' => [nil, nil, 0]}
    end
    
    it "should merge the results and update the file" do
      res = CoverMe::Results.merge_results!(@more_results)
      res.should be_kind_of(Hash)
      res.should == {'file1' => [0, 1, 2],
                     'file2' => [nil, 1, 0]}
      File.read(CoverMe.config.results.store).should == res.inspect
    end
    
    it "should merge the results and create a new file if there isn't one" do
      res = CoverMe::Results.merge_results!(@more_results, @idontexist_path)
      res.should be_kind_of(Hash)
      res.should == @more_results
      File.read(@idontexist_path).should == res.inspect
    end

  end
  
end
