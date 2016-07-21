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
      array: Validation::ArrayValidator,
      boolean: Validation::BooleanValidator,
      bytes: Validation::StringValidator,
      double: Validation::FloatValidator,
      enum: Validation::EnumValidator,
      error: Validation::RecordValidator,
      fixed: Validation::FixedValidator,
      float: Validation::FloatValidator,
      int: Validation::IntValidator,
      long: Validation::LongValidator,
      map: Validation::MapValidator,
      null: Validation::NullValidator,
      record: Validation::RecordValidator,
      request: Validation::RecordValidator,
      string: Validation::StringValidator,
      union: Validation::UnionValidator,
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
