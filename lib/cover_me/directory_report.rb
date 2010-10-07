# Used to represent the directory summary.
class CoverMe::DirectoryReport
  attr_accessor :name
  attr_accessor :reports
  attr_accessor :lines_of_code
  attr_accessor :lines_executed

  def initialize(name, reports) # :nodoc:
    self.name = name
    self.reports = reports
    self.lines_of_code = 0
    self.lines_executed = 0
    reports.each do |report|
      self.lines_of_code += report.lines_of_code
      self.lines_executed += report.lines_executed
    end
  end

  class << self
    def summarize(reports)
      reports_by_dir = reports.group_by do |report|
        dir_for_file(report.filename)
      end

      reports_by_dir.map do |dir,reports|
        self.new(dir, reports)
      end
    end

  private
    def dir_for_file(filename)
      File.dirname(filename).split(File::SEPARATOR).join('.')
    end
  end
end
