module Avro
  module Validation
    class FloatValidator
      include Validation::Helpers

      def validate(expected_schema, datum, path, result)
        add_mismatch_type_error(expected_schema, datum, path, result) unless [Float, Fixnum, Bignum].any?(&datum.method(:is_a?))
      end
    end
  end
end
