module CoverMe
  module Results
    
    class << self
      
      def read_results(path = CoverMe.config.results.store)
        data = {}
        if File.exists?(path)
          data = eval(File.read(path)) || {}
        end
        return data
      end
      
      def merge_results!(cov_results, path = CoverMe.config.results.store)
        
        data = CoverMe::Results.read_results(path)
        
        cov_results.each do |file, results|
          if data.has_key?(file)
            results.each_with_index do |result, i|
              summed_value = result # default
              if result.nil?
                summed_value = data[file][i]
              elsif !data[file][i].nil?
                summed_value = data[file][i] + result
              end
              data[file][i] = summed_value
            end
          else
            data[file] = results
          end
        end

        File.open(path, 'w') do |f|
          f.write(data.inspect)
        end
        
        return data
      end
      
    end
    
  end # Results
end # CoverMe