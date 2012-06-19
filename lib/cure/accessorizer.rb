module Cure
  module Accessorizer
    def accessorize(hash)
      hash.each do |key, value|
        self.class.name.constantize.send :attr_accessor, key.downcase.to_sym
        self.send :instance_variable_set, "@#{key.downcase}".to_sym, value
      end
    end
  end
end
