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

# Implements the `Devp2p::Identity` module handling any kind of p2p node addresses
# and client identifiers.
module Devp2p::Identity
  # A `Client` is a node implementing the `Devp2p` module and usually comes with
  # name, identity, and a version.
  #
  # Properties:
  # * `name` (`String`): the name of the `Client` which should be consistant across an implementation.
  # * `identity` (`(String)?`): a customizable identity.
  # * `version` (`String`): a sensible version string, e.g., `1.9.7`.
  #
  # ```
  # cli = Devp2p::Identity::Client.new "Cryeth", "Superhero42", "1.9.7"
  # cli.to_s
  # # => "Cryeth/Superhero42/v1.9.7"
  # ```
  class Client
    # The name of the `Client` which should be consistant across an implementation.
    property name : String

    # A customizable identity.
    property identity : (String)?

    # A sensible version string, e.g., `1.9.7`.
    property version : String

    # Generates a default `devp2p-cr-node` client.
    #
    # ```
    # cli = Devp2p::Identity::Client.new
    # cli.to_s
    # # => "devp2p-cr-node/v0.1.0-crystalv0.32.1"
    # ```
    def initialize
      @name = "devp2p-cr-node"
      @version = "v#{VERSION}-crystalv#{Crystal::VERSION}"
    end

    # Generates a custamizable client coming with name, identity, and a version.
    #
    # Parameters:
    # * `name` (`String`): The name of the `Client` which should be consistant across an implementation.
    # * `identity` (`(String)?`): A customizable identity.
    # * `version` (`String`): A sensible version string, e.g., `1.9.7`.
    #
    # ```
    # cli = Devp2p::Identity::Client.new "Cryeth", "Superhero42", "1.9.7"
    # cli.to_s
    # # => "Cryeth/Superhero42/v1.9.7"
    # ```
    def initialize(@name, @identity, @version)
    end

    # Returns a string literal containing client name, identity, and version.
    #
    # ```
    # cli.to_s
    # # => "devp2p-cr-node/v0.1.0-crystalv0.32.1"
    # ```
    def to_s
      id = "#{@name}/#{@identity}/#{@version}"
      id = "#{@name}/#{@version}" if @identity.nil?
      return id
    end
  end

  # A `Node` is a peer in a `Devp2p` network containing an `Secp256k1::Ethereum::Enode` address and a `Client` identifier.
  #
  # Properties:
  # * `enode` (`Secp256k1::Ethereum::Enode`): A `Devp2p` enode containing a `Secp256k1::Keypair` and an IP address.
  #
  # ```
  # nod = Devp2p::Identity::Node.new
  # nod.to_s
  # # => "enode://bf0cf8c934bd3c57e962fdf2a47e99d6136b047f987ee2e0cb03110cafd92afc981974428f8162d3f8fce2f58d4e56341478e87d092aeb3a0edf8af97d638d04@31.33.3.37:31337"
  # ```
  class Node
    property client : Devp2p::Identity::Client
    property enode : Secp256k1::Ethereum::Enode

    def initialize
      @client = Devp2p::Identity::Client.new
      @enode = Secp256k1::Ethereum::Enode.new
    end

    def initialize(@client, keys : Secp256k1::Keypair)
      @enode = Secp256k1::Ethereum::Enode.new keys
    end

    def initialize(@client, keys : Secp256k1::Keypair, port : Int32)
      @enode = Secp256k1::Ethereum::Enode.new keys, port
    end

    def initialize(@client, keys : Secp256k1::Keypair, ip : String, port : Int32)
      @enode = Secp256k1::Ethereum::Enode.new keys, ip, port
    end

    def get_keys
      return @enode.key_pair
    end

    def get_ip_and_port
      return @enode.address
    end

    def get_client_version
      return @client.to_s
    end

    def to_s
      return @enode.to_s
    end
  end
end
