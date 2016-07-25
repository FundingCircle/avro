# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module Avro
  class SchemaValidator
    extend Validation::Helpers

    VALIDATORS = {
      array: Validation::ArrayValidator.new,
      boolean: Validation::BooleanValidator.new,
      bytes: Validation::StringValidator.new,
      double: Validation::FloatValidator.new,
      enum: Validation::EnumValidator.new,
      error: Validation::RecordValidator.new,
      fixed: Validation::FixedValidator.new,
      float: Validation::FloatValidator.new,
      int: Validation::IntValidator.new,
      long: Validation::LongValidator.new,
      map: Validation::MapValidator.new,
      null: Validation::NullValidator.new,
      record: Validation::RecordValidator.new,
      request: Validation::RecordValidator.new,
      string: Validation::StringValidator.new,
      union: Validation::UnionValidator.new,
    }.freeze
    private_constant :VALIDATORS

    class << self
      def validate!(expected_schema, datum)
        result = Result.new
        validate_recursive(expected_schema, datum, ROOT_IDENTIFIER, result)
        fail ValidationError, result if result.failure?
        result
      end

      def validate_recursive(expected_schema, datum, path, result)
        validator_for(expected_schema).validate(expected_schema, datum, path, result)
      end

      private

      def validator_for(schema)
        VALIDATORS.fetch(schema.type_sym) do
          fail "Unexpected schema type #{schema.type_sym} #{schema.inspect}"
        end
      end
    end
  end
end
