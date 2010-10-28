# Processes the coverage results and then formats them.
class CoverMe::Processor
  
  attr_accessor :coverage_results
  attr_accessor :options
  attr_accessor :index
  
  def initialize(coverage_results, options = {}) # :nodoc:
    self.coverage_results = coverage_results
    self.options = ({:pattern => CoverMe.config.file_pattern,
                     :formatter => CoverMe.config.formatter.new}.merge(options)).to_mash
    self.index = CoverMe::Index.new
  end
  
  # Processes the coverage results and then formats them.
  # Coverage is only reported if the file matches the pattern
  # defined in the configuration. See the README for more
  # details.
  def process!
    self.coverage_results.map do |filename, coverage|
      if filename.match(self.options.pattern)
        report = CoverMe::Report.new(filename, coverage)
        if report.exists?
          self.index.reports << report
          self.options[:formatter].format(report)
        end
      end
    end
    self.options[:formatter].format(self.index)
    self.options[:formatter].finalize
  end
  
end