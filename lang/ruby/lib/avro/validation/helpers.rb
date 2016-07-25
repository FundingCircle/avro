module Avro
  module Validation
    module Helpers
      ROOT_IDENTIFIER = '.'.freeze
      PATH_SEPARATOR = '.'.freeze

      def deeper_path_for_hash(sub_key, path)
        "#{path}#{PATH_SEPARATOR}#{sub_key}".squeeze(PATH_SEPARATOR)
      end

      def actual_value_message(value)
        avro_type = ruby_to_avro_type(value.class)
        if value.nil?
          avro_type
        else
          "#{avro_type} with value #{value.inspect}"
        end
      end

      def ruby_to_avro_type(ruby_class)
        {
          NilClass => 'null',
          String => 'string',
          Fixnum => 'int',
          Bignum => 'long',
          Float => 'float',
          Hash => 'record'
        }.fetch(ruby_class, ruby_class)
      end

      def add_mismatch_type_error(expected_schema, datum, path, result)
        result.add_error(path, "expected type #{expected_schema.type_sym}, got #{actual_value_message(datum)}")
      end
    end
  end
end
