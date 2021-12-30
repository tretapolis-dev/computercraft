repo = "https://raw.githubusercontent.com/tretapolis-dev/computercraft/main/"
name = "test"
write("Connecting to " .. repo .. name .. ".lua ...")

local ok, err = http.checkURL(repo .. name .. ".lua")
if not ok then
    print("Failed.")
    if err then printError(err) end
    return nil
end

local response = http.get(repo .. name .. ".lua", nil, true)
if not response then
    print("Failed.")
    return nil
end

print("Success.")

local sResponse = response.readAll()
response.close()
local sPath = shell.resolve(name)
if fs.exists(sPath) then fs.delete(sPath) end
if sResponse then
    local file = fs.open(sPath, "wb")
    file.write(sResponse)
    file.close()
    print("Downloaded as " .. name)
end
