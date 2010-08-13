class CoverMe::Report
  attr_accessor :original_filename
  attr_accessor :filename
  attr_accessor :coverage
  attr_accessor :lines
  attr_accessor :lines_of_code
  attr_accessor :executed_percent
  attr_accessor :unexecuted_percent
  
  def initialize(filename, coverage = [])
    self.original_filename = filename
    self.filename = filename.gsub(CoverMe.config.project.root.to_s, '').gsub(/^\//, '')
    self.coverage = coverage
    self.lines = self.coverage.size
    self.lines_of_code = self.coverage.reject{|x| x.nil?}.size
    self.executed_percent = ((self.coverage.reject{|x| x.nil? || x < 1}.size.to_f / self.lines_of_code.to_f) * 100).round(1)
    self.unexecuted_percent = (100 - self.executed_percent).round(1)
  end
  
  def proximity
    unless @proximity
      @proximity = 'miss'
      @proximity = 'near' if self.executed_percent >= 90
      @proximity = 'hit' if self.executed_percent >= 100
    end
    return @proximity
  end
  
  def hit_type(cov)
    cov ? (cov > 0 ? 'hit' : 'miss') : 'never'
  end
  
  def <=>(other)
    self.filename <=> other.filename
  end
  
  # returns an Array
  def source
    unless @source
      @source = File.readlines(self.original_filename)
    end
    return @source
  end
  
  def test_file_name
    unless @test_file_name
      self.filename.match(/\/?(.+)\.rb/ix)
      name = $1.gsub(/^app/, '')
      path = File.join(CoverMe.config.project.root, 'spec', "#{name}_spec.rb")
      if File.exists?(path)
        @test_file_name = path
      else
        path = File.join(CoverMe.config.project.root, 'test', "#{name}_test.rb")
        if File.exists?(path)
          @test_file_name = path
        end
      end
    end
    return @test_file_name
  end
  
  def test_file
    if self.test_file_name
      return File.read(self.test_file_name)
    end
    return nil
  end
  
  def short_test_file_name
    unless @short_test_file_name
      if self.test_file_name
        @short_test_file_name = self.test_file_name.gsub(CoverMe.config.project.root.to_s + '/', '')
      end
    end
    return @short_test_file_name
  end
  
end