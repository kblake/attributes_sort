module AttributesSort
  def self.included(receiver)
    receiver.instance_eval do
      def do_attributes_sort(collection, attributes)	
				collection.sort_by { |object| attributes.map { |attribute| object.send(attribute) }}				
      end
    end
    Array.class_eval do
			def sortable_attributes?
				self.all? {|object| @attributes.all?{|attribute| object.respond_to?(attribute)}}
			end

      def class_type
				raise "All objects must respond to sort criteria"unless sortable_attributes?	
      	self.first.class
			end

      def attr_sort(options = {})
				@attributes = options[:sort_by]
        raise "You must pass in sort_by criteria" unless @attributes 
        class_type.do_attributes_sort(self, @attributes)
      end
    end
  end
end

