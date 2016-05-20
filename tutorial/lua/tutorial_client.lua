package.path = package.path .. ";./gen-lua/?.lua;../../lib/lua/?.lua"
package.cpath = package.cpath .. ";/usr/local/lib/?.so"
require('TSocket')
require('TBinaryProtocol')
require('liblualongnumber')
require('TTransport')
require('tutorial_Calculator')

local client

function teardown()
  if client then
    -- Shuts down the server
--    client:testVoid()

    -- close the connection
    client:close()
  end
end

function doTutorial()
  local socket = TSocket:new{
    host = 'localhost',
    port = 9090
  }
  socket:open()
  assert(socket, 'Failed to create client socket')
  socket:setTimeout(5000)

  local protocol = TBinaryProtocol:new{
    trans = socket
  }
  assert(protocol, 'Failed to create binary protocol')

  client = CalculatorClient:new{
    protocol = protocol
  }
  result = client:add(1,1)
  print(result)

end

doTutorial()
teardown()

