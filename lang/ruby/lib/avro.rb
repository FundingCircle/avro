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

require 'multi_json'
require 'set'
require 'digest/md5'
require 'net/http'
require 'stringio'
require 'zlib'

module Avro
  VERSION = "FIXME"

  class AvroError < StandardError; end

  class AvroTypeError < Avro::AvroError
    def initialize(schm=nil, datum=nil, msg=nil)
      msg ||= "Not a #{schm.to_s}: #{datum}"
      super(msg)
    end
  end
end

require 'avro/schema'
require 'avro/io'
require 'avro/data_file'
require 'avro/protocol'
require 'avro/ipc'
require 'avro/schema_normalization'
require 'avro/validation/helpers'
require 'avro/validation/array_validator'
require 'avro/validation/boolean_validator'
require 'avro/validation/enum_validator'
require 'avro/validation/fixed_validator'
require 'avro/validation/float_validator'
require 'avro/validation/int_validator'
require 'avro/validation/long_validator'
require 'avro/validation/map_validator'
require 'avro/validation/null_validator'
require 'avro/validation/record_validator'
require 'avro/validation/string_validator'
require 'avro/validation/union_validator'
require 'avro/schema_validator'
