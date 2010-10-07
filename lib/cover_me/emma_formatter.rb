# Generates Emma-style xml coverage files.
class CoverMe::EmmaFormatter < CoverMe::Formatter

  def initialize(options = {}) # :nodoc:
    super
    self.options = ({:output_path => CoverMe.config.emma_formatter.output_path}.merge(self.options)).to_mash
  end

  def format_report(report)
    # nothing to do
  end

  # Formats a CoverMe::Index object using the _emma.xml.erb_ template
  def format_index(index)
    # puts index.inspect
    reports_by_module = aggregate_modules(index)
    global = aggregate_global(reports_by_module)
    write_file('coverage') do |file|
      file.write(self.template('emma.xml.erb').result(binding))
    end
  end

  protected
  def write_file(filename, extension = '.xml', &block) # :nodoc:
    path = File.join(self.options.output_path, filename)
    FileUtils.mkdir_p(File.dirname(path))
    File.open(path + extension, 'w', &block)
  end
  
  def aggregate_modules(index)
    reports_by_module = index.reports.group_by do |report|
      report.filename.split(File::SEPARATOR)[0..-2]
    end
    reports_by_module = Hash[reports_by_module.map do |mod,reports|
      counts = reports.inject([0,0]) do |counts,report|
        counts[0] += report.lines_executed
        counts[1] += report.lines_of_code
        counts
      end
      [mod, [counts, reports]]
    end]
  end
  
  def aggregate_global(reports_by_module)
    lines_executed = 0
    lines_of_code = 0
    reports_by_module.each_value do |counts,ignore|
      lines_executed += counts[0]
      lines_of_code += counts[1]
    end
    [lines_executed, lines_of_code]
  end
end