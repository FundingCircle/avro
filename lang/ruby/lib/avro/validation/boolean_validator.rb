module Avro
  module Validation
    class BooleanValidator
      include Validation::Helpers

      def validate(expected_schema, datum, path, result)
        add_mismatch_type_error(expected_schema, datum, path, result) unless [true, false].include?(datum)
      end
    end
  end
end
