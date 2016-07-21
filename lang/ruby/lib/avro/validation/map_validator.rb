module Avro
  module Validation
    class MapValidator
      extend Validation::Helpers

      class << self
        def validate(expected_schema, datum, path, result)
          datum.keys.each do |k|
            result.add_error(path, "unexpected key type '#{ruby_to_avro_type(k.class)}' in map") unless k.is_a?(String)
          end
          datum.each do |k, v|
            deeper_path = deeper_path_for_hash(k, path)
            SchemaValidator.validate_recursive(expected_schema.values, v, deeper_path, result)
          end
        end
      end
    end
  end
end
