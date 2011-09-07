# Used to generate an index page for the code coverage.
class CoverMe::Index
  attr_accessor :reports
  
  def initialize(reports = []) # :nodoc:
    self.reports = reports
  end
  
  # Returns the total number of lines across all files.
  def total_lines
    unless @total_lines
      @total_lines = self.reports.inject(0) {|sum, x| sum += x.lines; sum}
    end
    return @total_lines
  end
  
  # Returns the total number of lines of code across all files.
  def total_loc
    unless @total_loc
      @total_loc = self.reports.inject(0) {|sum, x| sum += x.lines_of_code; sum}
    end
    return @total_loc
  end

  # Returns the total number of untested lines of code across all files.
  def total_untested_loc
    unless @total_untested_loc
      @total_untested_loc = self.reports.inject(0) {|sum, x| sum += (x.lines_of_code - x.lines_executed); sum}
    end
    return @total_untested_loc
  end

  # Returns an average percent across all files.
  def percent_tested
    unless @percent_tested
      @percent_tested = (total_loc - total_untested_loc).to_f / (total_loc).to_f * 100
      @percent_tested = (@percent_tested.nan? ? 0 : @percent_tested.round(2))
    end
    return @percent_tested
  end
  
end
