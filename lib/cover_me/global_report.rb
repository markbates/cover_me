# Used to represent the module summary.
class CoverMe::GlobalReport
  attr_accessor :lines_of_code
  attr_accessor :lines_executed

  def initialize(reports) # :nodoc:
    self.lines_of_code = 0
    self.lines_executed = 0
    reports.each do |report|
      self.lines_of_code += report.lines_of_code
      self.lines_executed += report.lines_executed
    end
  end
end
