class CoverMe::HtmlFormatter < CoverMe::Formatter
  
  def initialize(options = {})
    super
    self.options = ({:output_path => CoverMe.config.html_formatter.output_path}.merge(self.options)).to_mash
  end
  
  def format_report(report)
    write_file(report.filename) do |file|
      file.write(self.template('report.html.erb').result(binding))
    end
  end
  
  def format_index(index)
    write_file('index') do |file|
      file.write(self.template('index.html.erb').result(binding))
    end
  end
  
  def finalize
    super
    CoverMe.config.html_formatter.finalizer_files.each do |name, t|
      write_file(name, '') do |file|
        file.write(self.template(t).result(binding))
      end
    end
  end
  
  protected
  def write_file(filename, extension = '.html', &block)
    path = File.join(self.options.output_path, filename)
    FileUtils.mkdir_p(File.dirname(path))
    File.open(path + extension, 'w', &block)
  end
  
end

# class CoverMe::Formatter
#   
#   attr_accessor :coverages
#   attr_accessor :index
#   attr_accessor :options
#   
#   def initialize(coverages, options = {})
#     self.coverages = coverages
#     self.index = CoverMe::Index.new
#     self.options = ({:pattern => CoverMe.config.file_pattern}.merge(options)).to_mash
#   end
#   
#   def format
#     report_template = self.template('report.html.erb')
# 
#     self.coverages.map do |filename, coverage|
#       if filename.match(self.options.pattern)
#         report = CoverMe::Report.new(filename.gsub(CoverMe.config.project.root.to_s, ''), coverage)
#         self.index.reports << report
#         source = File.readlines(filename)
#         path = File.join(CoverMe.config.project.root, "coverage", report.filename)
#         FileUtils.mkdir_p(File.dirname(path))
#         File.open(path + '.html', 'w') do |file|
#           file.write(report_template.result(binding))
#         end
#       end
#     end
#     
#     self.write_index
#   end
#   
#   protected
#   def write_index
#     {'index.html' => 'index.html.erb', 'report.css' => 'report.css', 
#       'index.css' => 'index.css', 'jquery.js' => 'jquery.js',
#       'jquery.tablesorter.js' => 'jquery.tablesorter.js'}.each do |k, v|
#       File.open(File.join(CoverMe.config.project.root, 'coverage', k), 'w') do |file|
#         file.write(self.template(v).result(binding))
#       end
#     end
#   end
#   
#   def template(file)
#     ERB.new(File.read(File.join(File.dirname(__FILE__), 'templates', file)))
#   end
#   
# end