# Processes the coverage results and then formats them.
class CoverMe::Processor
  
  attr_accessor :coverage_results
  attr_accessor :options
  attr_accessor :index
  
  def initialize(coverage_results, options = {}) # :nodoc:
    self.coverage_results = coverage_results
    self.options = ({:patterns => CoverMe.config.file_pattern,
                     :exclude_patterns => CoverMe.config.exclude_file_patterns,
                     :formatter => CoverMe.config.formatter.new}.merge(options)).to_mash
    self.index = CoverMe::Index.new
    self.options[:patterns] = [self.options[:patterns]].flatten
    self.options[:exclude_patterns] = [self.options[:exclude_patterns]].flatten
  end
  
  # Processes the coverage results and then formats them.
  # Coverage is only reported if the file matches the pattern
  # defined in the configuration. See the README for more
  # details.
  def process!
    self.coverage_results.map do |filename, coverage|
      # next unless filename.match(/#{CoverMe.config.project.root}/)
      exclude = false
      self.options[:exclude_patterns].each do |pattern|
        if filename.match(pattern)
          exclude = true
          break
        end
      end
      next if exclude
      self.options[:patterns].each do |pattern|
        if filename.match(pattern)
          report = CoverMe::Report.new(filename, coverage)
          if report.exists?
            self.index.reports << report
            self.options[:formatter].format(report)
          end
          break
        end
      end
    end
    self.options[:formatter].format(self.index)
    self.options[:formatter].finalize
  end
  
end