module Avro
  module Validation
    class EnumValidator
      include Validation::Helpers

      def validate(expected_schema, datum, path, result)
        message = "expected enum with values #{expected_schema.symbols}, got #{actual_value_message(datum)}"
        result.add_error(path, message) unless expected_schema.symbols.include?(datum)
      end
    end
  end
end
