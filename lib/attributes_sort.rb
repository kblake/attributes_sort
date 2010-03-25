module AttributesSort
  def self.included(receiver)
    receiver.instance_eval do
      def build_attributes(attributes)
        "[" << attributes.map!{|attribute| "object.#{attribute}"}.join(",") << "]"
      end

      def do_attributes_sort(collection, attributes)
				attribute_array_string = build_attributes(attributes)
        collection.sort_by{|object| eval(attribute_array_string)}
      end
    end
    Array.class_eval do
			def sortable_attributes?
				self.all? {|object| @attributes.all?{|attribute| object.respond_to?(attribute)}}
			end

      def class_type
        klass = self.first.class

        #use duck type check respond to check instead				
        #is_same = self.all?{|object| object.class == klass}
				#raise "All objects must be of the same class type" unless is_same

				raise "All objects must respond to sort criteria"unless sortable_attributes?	
        klass
      end

      def attr_sort(options = {})
				@attributes = options[:sort_by]
        raise "You must pass in sort_by criteria" unless @attributes 
        class_type.do_attributes_sort(self, @attributes)
      end
    end
  end
end

