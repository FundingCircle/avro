module Avro
  module Validation
    class UnionValidator
      include Validation::Helpers

      def validate(expected_schema, datum, path, result)
        if expected_schema.schemas.size == 1
          SchemaValidator.validate_recursive(expected_schema.schemas.first, datum, path, result)
        else
          sub_results_by_type = expected_schema.schemas.map do |schema|
            r = SchemaValidator::Result.new
            SchemaValidator.validate_recursive(schema, datum, path, r)
            { type: schema.type_sym, result: r }
          end
          complex_types = [:array, :error, :map, :record, :request]
          if sub_results_by_type.all? { |r| r[:result].failure? }
            complex_type_failed = sub_results_by_type.detect { |r| r[:result].failure? && complex_types.include?(r[:type]) }
            if complex_type_failed
              result.errors.concat(complex_type_failed[:result].errors)
            else
              types = expected_schema.schemas.map { |s| "'#{s.type_sym}'" }.join(', ')
              result.add_error(path, "expected union of [#{types}], got #{actual_value_message(datum)}")
            end
          end
        end
      end
    end
  end
end
