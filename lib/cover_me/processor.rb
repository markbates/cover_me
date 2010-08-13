class CoverMe::Processor
  
  attr_accessor :coverage_results
  attr_accessor :options
  attr_accessor :index
  
  def initialize(coverage_results, options = {})
    self.coverage_results = coverage_results
    self.options = ({:pattern => CoverMe.config.file_pattern,
                     :formatter => CoverMe.config.formatter.new}.merge(options)).to_mash
    self.index = CoverMe::Index.new
  end
  
  def process!
    self.coverage_results.map do |filename, coverage|
      if filename.match(self.options.pattern)
        report = CoverMe::Report.new(filename, coverage)
        self.index.reports << report
        self.options.formatter.format(report)
        # path = File.join(CoverMe.config.project.root, "coverage", report.filename)
        # FileUtils.mkdir_p(File.dirname(path))
        # File.open(path + '.html', 'w') do |file|
        #   file.write(report_template.result(binding))
        # end
      end
    end
    self.options.formatter.format(self.index)
    self.options.formatter.finalize
  end
  
end