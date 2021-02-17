# Any copyright is dedicated to the Public Domain.
# https://creativecommons.org/publicdomain/zero/1.0/
#
# Contributors: @q9f

require "./src/*"
require "colorize"

# just emulating your client's logger here
def log(m : String)
  t = Time.local.to_s("%Y-%m-%d %H:%M:%S")
  puts "#{t.colorize(:dark_gray).bold}  #{m}"
end

# we don't have any persistance logic yet
dir = "None"

# create a client with a name, identity, and version
cli = Devp2p::Identity::Client.new "Parody-Etherium", "devp2p-try-cr", "v2.5.13-stable/crystalv#{Crystal::VERSION}"

# create a node for your client implementation with a new random key
p2p = Devp2p::Identity::Node.new cli, Secp256k1::Keypair.new

# do something
log "Starting #{cli.to_s.colorize(:white).bold}"
log "Keys path #{dir.colorize(:white).bold}"
log "Public node URL: #{p2p.to_s.colorize(:white).bold}"
log "Nothing to do. Finishing work, please wait..."
