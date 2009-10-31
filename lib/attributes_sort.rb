module AttributesSort
  def self.included(receiver)
    Array.class_eval do
      def attr_sort(options = {})
				raise "You must pass in sort_by criteria" unless options[:sort_by]
        klass = self.first.class
        klass.instance_eval do
          def do_attributes_sort(collection, options={})
            attributes = options[:sort_by].inject("["){|attribute_string, attribute| attribute_string << "object.#{attribute},"} + "]"
            collection.sort_by{|object| eval(attributes)}
          end
        end
				begin
        	klass.do_attributes_sort(self, options)
				rescue NoMethodError
					raise "You must sort by an attribute that exists in the object that you are sorting"
				end
      end
    end
  end
end
