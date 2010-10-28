# Used to represent the details of a particular file.
class CoverMe::Report
  attr_accessor :original_filename # full filename, "/Users/me/my/file.rb"
  attr_accessor :filename # shortened relative name, "my/file.rb"
  attr_accessor :coverage
  attr_accessor :lines
  attr_accessor :lines_of_code
  attr_accessor :lines_executed
  attr_accessor :executed_percent
  attr_accessor :unexecuted_percent
  
  def initialize(filename, coverage = []) # :nodoc:
    self.original_filename = filename
    self.filename = filename.gsub(CoverMe.config.project.root.to_s, '').gsub(/^\//, '')
    self.coverage = coverage
    self.lines = self.coverage.size
    self.lines_of_code = self.coverage.reject{|x| x.nil?}.size
    self.lines_executed = self.coverage.reject{|x| x.nil? || x < 1}.size
    self.executed_percent = ((self.lines_executed.to_f / self.lines_of_code.to_f) * 100).round(1)
    self.unexecuted_percent = (100 - self.executed_percent).round(1)
  end
  
  # Returns <code>'hit'</code> if the file was executed 100%, <code>'near'</code> if the
  # file was executed more than 90%, or <code>'miss'</code> if less than 90%.
  def proximity
    unless @proximity
      @proximity = 'miss'
      @proximity = 'near' if self.executed_percent >= CoverMe.config.proximity.near
      @proximity = 'hit' if self.executed_percent >= CoverMe.config.proximity.hit
    end
    return @proximity
  end
  
  # Takes in a number (how much the line was executed) and returns
  # <code>'hit'</code> if the number is greater than <code>0</code>,
  # <code>'miss'</code> if the number is <code>0</code>, and
  # <code>'never'</code> if the line is never executed. Lines that
  # return never are lines of code that are not considered 'executable',
  # think comments and <code>end</code> tags.
  def hit_type(cov)
    cov ? (cov > 0 ? 'hit' : 'miss') : 'never'
  end
  
  def <=>(other) # :nodoc:
    self.filename <=> other.filename
  end
  
  def exists?
    File.exists?(self.original_filename)
  end
  
  # Reads in the original file and returns an <code>Array</code>
  # representing the lines of that file.
  def source
    unless @source
      @source = File.readlines(self.original_filename)
    end
    return @source
  end
  
  # Attempts to find an associated test/spec file.
  # 
  # Example:
  #   report = CoverMe::Report.new('/Users/me/app/models/user.rb')
  #   # if using rspec:
  #   report.test_file_name # => '/Users/me/spec/models/user_spec.rb'
  #   # if using test/unit:
  #   report.test_file_name # => '/Users/me/test/models/user_test.rb'
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
  
  # Returns the test file, if there is one, as a <code>String</code>
  def test_file
    if self.test_file_name
      return File.read(self.test_file_name)
    end
    return nil
  end
  
  # Returns the short name, relative, of the test file, if there is one.
  # Example:
  # 
  #   report.test_file_name # => '/Users/me/spec/models/user_spec.rb'
  #   report.short_test_file_name # => 'spec/models/user_spec.rb'
  def short_test_file_name
    unless @short_test_file_name
      if self.test_file_name
        @short_test_file_name = self.test_file_name.gsub(CoverMe.config.project.root.to_s + '/', '')
      end
    end
    return @short_test_file_name
  end
  
end