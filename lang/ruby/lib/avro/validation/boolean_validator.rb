module Avro
  module Validation
    class BooleanValidator
      extend Validation::Helpers

      class << self
        def validate(expected_schema, datum, path, result)
          add_mismatch_type_error(expected_schema, datum, path, result) unless [true, false].include?(datum)
        end
      end
    end
  end
end
