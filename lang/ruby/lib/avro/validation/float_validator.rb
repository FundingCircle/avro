module Avro
  module Validation
    class FloatValidator
      extend Validation::Helpers

      class << self
        def validate(expected_schema, datum, path, result)
          add_mismatch_type_error(expected_schema, datum, path, result) unless [Float, Fixnum, Bignum].any?(&datum.method(:is_a?))
        end
      end
    end
  end
end
