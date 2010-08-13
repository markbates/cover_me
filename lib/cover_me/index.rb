class CoverMe::Index
  attr_accessor :reports
  
  def initialize(reports = [])
    self.reports = reports
  end
  
  def total_lines
    unless @total_lines
      @total_lines = self.reports.inject(0) {|sum, x| sum += x.lines; sum}
    end
    return @total_lines
  end
  
  def total_loc
    unless @total_loc
      @total_loc = self.reports.inject(0) {|sum, x| sum += x.lines_of_code; sum}
    end
    return @total_loc
  end
  
  def percent_tested
    unless @percent_tested
      executed_percent = self.reports.inject(0) {|sum, x| sum += x.executed_percent; sum}
      @percent_tested = (executed_percent / self.reports.size.to_f).round(2)
    end
    return @percent_tested
  end
  
end