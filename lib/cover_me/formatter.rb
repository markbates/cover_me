# A base class for implementing formatters of the coverage.
# 
# All subclasses must implement the following methods:
# 
#   def format_report(report)
#   end
# 
#   def format_index(index)
#   end
class CoverMe::Formatter
  
  attr_accessor :options
  
  def initialize(options = {}) # :nodoc:
    self.options = options
  end
  
  # Given an object, CoverMe::Report or CoverMe::Index
  # it will call the appropriate format method in the subclass.
  def format(object)
    if object.is_a?(CoverMe::Report)
      return send(:format_report, object)
    elsif object.is_a?(CoverMe::Index)
      return send(:format_index, object)
    end
  end
  
  # Called when all the reports and the index have been formatted.
  # Usually used for outputting files such as .css and .js files.
  # Can safely be overridden by subclasses
  def finalize
  end
  
  # Returns an ERB object based on the template file requested.
  # Template files are expected to live in the _templates_ directory.
  # Can receive trim_mode of ERB as second argument.
  # 
  # Example:
  #   template('index.html.erb') # => ERB object
  #   templaet('console.erb', '-') # => ERB object with trim_mode "-"
  # 
  # The ERB object return still needs to be bound and processed.
  def template(file, trim_mode = nil)
    ERB.new(File.read(File.join(File.dirname(__FILE__), 'templates', file)), nil, trim_mode)
  end
  
end
