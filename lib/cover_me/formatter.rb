class CoverMe::Formatter
  
  attr_accessor :options
  
  def initialize(options = {})
    self.options = options
  end
  
  def format(object)
    if object.is_a?(CoverMe::Report)
      return send(:format_report, object)
    elsif object.is_a?(CoverMe::Index)
      return send(:format_index, object)
    end
  end
  
  def finalize
  end
  
  def template(file)
    ERB.new(File.read(File.join(File.dirname(__FILE__), 'templates', file)))
  end
  
end