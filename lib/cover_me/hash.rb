class Hash # :nodoc:
  
  def to_mash
    h = self.dup
    h.each do |k, v|
      if v.is_a?(Hash) && !v.is_a?(Hashie::Mash)
        h[k] = v.to_mash
      end
    end
    Hashie::Mash.new(h)
  end
  
end