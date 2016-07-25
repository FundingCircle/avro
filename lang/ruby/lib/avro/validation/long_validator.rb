module Avro
  module Validation
    class LongValidator
      include Validation::Helpers

      def validate(expected_schema, datum, path, result)
        if datum.is_a?(Fixnum) || datum.is_a?(Bignum)
          range = (Schema::LONG_MIN_VALUE..Schema::LONG_MAX_VALUE)
          result.add_error(path, "out of bound value #{datum}") unless range.cover?(datum)
        else
          add_mismatch_type_error(expected_schema, datum, path, result)
        end
      end
    end
  end
end
