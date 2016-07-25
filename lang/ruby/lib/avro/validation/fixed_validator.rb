module Avro
  module Validation
    class FixedValidator
      include Validation::Helpers

      def validate(expected_schema, datum, path, result)
        if datum.is_a? String
          message = "expected fixed with size #{expected_schema.size}, got \"#{datum}\" with size #{datum.bytesize}"
          result.add_error(path, message) unless datum.bytesize == expected_schema.size
        else
          result.add_error(path, "expected fixed with size #{expected_schema.size}, got #{actual_value_message(datum)}")
        end
      end
    end
  end
end
