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
    reports_by_dir = CoverMe::DirectoryReport.summarize(index.reports)
    global = CoverMe::GlobalReport.new(reports_by_dir)
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
end