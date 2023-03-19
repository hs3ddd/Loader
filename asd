-- Require Lua modules
local curl = require("luacurl.safe")
local socket = require("socket")

-- The URL of the API endpoint to fetch the Lua code
local url = "http://whitelist.happyhz.xyz:1599/test.php"

-- The Lua code to execute
local luaCode = "happyhz"

-- Initialize the cURL session
local c = curl.easy{
  url = url,
  post = true,
  postfields = "loadscript=" .. luaCode,
  writefunction = function(str)
    result = str
  end
}

-- Execute the cURL session
c:perform()

-- Close the cURL session
c:close()

-- Check for errors and handle them
if not result then
    print("Error: Failed to fetch Lua code from API endpoint.")
    return
end

-- Execute the Lua code
print("[HappyHz]: [1/3] Authenticating...")
local func, err = loadstring(result)
if not func then
    print("Error: Failed to execute Lua code.")
    return
end

-- Call the function with optional arguments
local success, err = pcall(func)

-- Print the result of executing the Lua code
print(success and "Success!" or "Error: " .. err)
