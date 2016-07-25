module Avro
  module Validation
    class StringValidator
      include Validation::Helpers

      def validate(expected_schema, datum, path, result)
        add_mismatch_type_error(expected_schema, datum, path, result) unless datum.is_a?(String)
      end
    end
  end
end
