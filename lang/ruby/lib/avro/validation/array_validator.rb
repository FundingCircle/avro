module Avro
  module Validation
    class ArrayValidator
      extend Validation::Helpers

      class << self
        def validate(expected_schema, datum, path, result)
          if datum.is_a?(Array)
            datum.each_with_index do |inner_datum, index|
              SchemaValidator.validate_recursive(expected_schema.items, inner_datum, path + "[#{index}]", result)
            end
          else
            add_mismatch_type_error(expected_schema, datum, path, result)
          end
        end
      end
    end
  end
end
