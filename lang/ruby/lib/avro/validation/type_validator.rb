module Avro
  module Validation
    class TypeValidator
      include Validation::Helpers

      def initialize(allowed_types)
        @allowed_types = allowed_types
      end

      def validate(expected_schema, datum, path, result)
        add_mismatch_type_error(expected_schema, datum, path, result) unless allowed_types.any? { |type| datum.is_a?(type) }
      end

      private

      attr_reader :allowed_types
    end
  end
end
