module Avro
  module Validation
    class NullValidator
      include Validation::Helpers

      def validate(expected_schema, datum, path, result)
        add_mismatch_type_error(expected_schema, datum, path, result) unless datum.nil?
      end
    end
  end
end
