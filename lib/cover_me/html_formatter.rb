# Generates pretty HTML of the code coverage.
class CoverMe::HtmlFormatter < CoverMe::Formatter
  
  def initialize(options = {}) # :nodoc:
    super
    self.options = ({:output_path => CoverMe.config.html_formatter.output_path}.merge(self.options)).to_mash
  end
  
  # Formats a CoverMe::Report object using the _report.html.erb_ template
  def format_report(report)
    write_file(report.filename) do |file|
      file.write(self.template('report.html.erb').result(binding))
    end
  end
  
  # Formats a CoverMe::Index object using the _index.html.erb_ template
  def format_index(index)
    write_file('index') do |file|
      file.write(self.template('index.html.erb').result(binding))
    end
  end
  
  # Generates some .css and .js files to make things look pretty and work well.
  def finalize
    super
    CoverMe.config.html_formatter.finalizer_files.each do |name, t|
      write_file(name, '') do |file|
        file.write(self.template(t).result(binding))
      end
    end
  end
  
  protected
  def write_file(filename, extension = '.html', &block) # :nodoc:
    path = File.join(self.options[:output_path], filename)
    FileUtils.mkdir_p(File.dirname(path))
    File.open(path + extension, 'w', &block)
  end
  
end