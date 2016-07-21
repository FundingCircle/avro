module Avro
  module Validation
    class StringValidator
      extend Validation::Helpers

      class << self
        def validate(expected_schema, datum, path, result)
          add_mismatch_type_error(expected_schema, datum, path, result) unless datum.is_a?(String)
        end
      end
    end
  end
end
