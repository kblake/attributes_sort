module AttributesSort
  def self.included(receiver)
    receiver.instance_eval do
      def build_attributes(attributes)
        "[" + attributes.map!{|a| "object.#{a}"}.join(",") + "]"
      end

      def do_attributes_sort(collection, options={})
        attributes = build_attributes(options[:sort_by])
        collection.sort_by{|object| eval(attributes)}
      end
    end
    Array.class_eval do
      def class_type
        klass = self.first.class
        is_same = self.all?{|object| object.class == klass}
        raise "All objects must be of the same class type" unless is_same
        klass
      end

      def attr_sort(options = {})
        raise "You must pass in sort_by criteria" unless options[:sort_by]
        begin
          class_type.do_attributes_sort(self, options)
        rescue NoMethodError
          raise "You must sort by an attribute that exists in the object that you are sorting"
        end
      end
    end
  end
end

