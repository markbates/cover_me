module CoverMe
  
  class << self
    
    # Yields up a configuration object when given a block. 
    # Without a block it just returns the configuration object.
    # Uses Configatron under the covers.
    # 
    # Example:
    #   CoverMe.config do |c|
    #     c.foo = :bar
    #   end
    # 
    #   CoverMe.config.foo # => :bar
    def config(&block)
      yield configatron.cover_me if block_given?
      configatron.cover_me
    end
    
    def set_defaults # :nodoc:
      CoverMe.config do |c|
        c.project.set_default(:root,
          Configatron::Delayed.new{defined?(Rails) ? Rails.root.to_s : Dir.pwd})
        c.results.set_default(:store, Configatron::Delayed.new {File.join(CoverMe.config.project.root, 'coverage.data')})
        c.set_default(:file_pattern, Configatron::Delayed.new do
          /(#{CoverMe.config.project.root}\/app\/.+\.rb|#{CoverMe.config.project.root}\/lib\/.+\.rb)/ix
        end)
        
        c.proximity.set_default(:near, 90)
        c.proximity.set_default(:hit, 100)
        
        c.set_default(:formatter, Configatron::Delayed.new {CoverMe::HtmlFormatter})
        c.set_default(:at_exit, Proc.new {
          if CoverMe.config.formatter == CoverMe::HtmlFormatter
            index = File.join(CoverMe.config.html_formatter.output_path, 'index.html')
            if File.exists?(index)
              `open #{index}`
            end
          end
        })
        c.html_formatter.set_default(:output_path, Configatron::Delayed.new {File.join(CoverMe.config.project.root, 'coverage')})
        c.html_formatter.set_default(:finalizer_files, {'report.css' => 'report.css', 'index.css' => 'index.css', 
                                                        'jquery.js' => 'jquery.js', 'jquery.tablesorter.js' => 'jquery.tablesorter.js'})
        c.emma_formatter.set_default(:output_path, Configatron::Delayed.new {File.join(CoverMe.config.project.root, 'coverage')})
      end
    end
    
  end
  
end