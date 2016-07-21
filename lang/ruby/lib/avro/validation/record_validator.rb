module Avro
  module Validation
    class RecordValidator
      extend Validation::Helpers

      class << self
        def validate(expected_schema, datum, path, result)
          if datum.is_a?(Hash)
            expected_schema.fields.each do |field|
              deeper_path = deeper_path_for_hash(field.name, path)
              SchemaValidator.validate_recursive(field.type, datum[field.name], deeper_path, result)
            end
          else
            add_mismatch_type_error(expected_schema, datum, path, result)
          end
        end
      end
    end
  end
end
