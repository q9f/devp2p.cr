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

require "./spec_helper"

# tests for the `Devp2p` module
describe Devp2p do
  # tests if we can create a valide `Devp2p::Identity`
  it "can create a node identity" do
    # private key taken from nick's edgeware tweet-storm
    # ref: https://twitter.com/nicksdjohnson/status/1146018827685126144
    priv = BigInt.new "d6c8ace470ab0ce03125cac6abf2779c199d21a47d3e75e93c212b1ec23cfe51", 16

    # generates a keypair from nick's private key
    keys = Secp256k1::Keypair.new priv

    # creates a node identiy with custom port and ip
    addr = Devp2p::Identity.new keys, "31.33.3.37", 31337

    # makes sure all address literals are prefixed with `enode://`
    addr.to_s[0, 8].should eq "enode://"

    # makes sure it correctly handles public keys
    addr.get_keys.to_s.should eq "bf0cf8c934bd3c57e962fdf2a47e99d6136b047f987ee2e0cb03110cafd92afc981974428f8162d3f8fce2f58d4e56341478e87d092aeb3a0edf8af97d638d04"

    # makes sure the address and port are represented correctly
    addr.get_ip_and_port.address.should eq "31.33.3.37"
    addr.get_ip_and_port.port.should eq 31337

    # ensures the correct node identity string literal representation
    addr.to_s.should eq addr.enode.to_s
    addr.to_s.should eq "enode://bf0cf8c934bd3c57e962fdf2a47e99d6136b047f987ee2e0cb03110cafd92afc981974428f8162d3f8fce2f58d4e56341478e87d092aeb3a0edf8af97d638d04@31.33.3.37:31337"
  end
end
