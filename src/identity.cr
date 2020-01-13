# Copyright 2020 @q9f
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "secp256k1"

module Devp2p
  class Identity
    property enode : Secp256k1::Ethereum::Enode

    def initialize
      @enode = Secp256k1::Ethereum::Enode.new
    end

    def initialize(keys)
      @enode = Secp256k1::Ethereum::Enode.new keys
    end

    def initialize(keys, port)
      @enode = Secp256k1::Ethereum::Enode.new keys, port
    end

    def initialize(keys, ip, port)
      @enode = Secp256k1::Ethereum::Enode.new keys, ip, port
    end

    def get_keys
      return @enode.key_pair
    end

    def get_ip_and_port
      return @enode.address
    end

    def to_s
      return @enode.to_s
    end
  end
end
