-- -- -- pastebin get 9wFXXLWx testpull
-- -- shell.run("clear")
-- -- -- settings
-- repo = "https://raw.githubusercontent.com/tretapolis-dev/computercraft/main/"
-- name = "test"
-- -- if fs.exists(name) == true then fs.delete(name) end
-- -- -- -
-- -- -- print("Downloading " .. name .. ".lua ...")
-- -- http.request(repo .. name .. ".lua", nil, {os.time()})
-- -- while true do
-- --     local event, url, h = os.pullEvent()
-- --     if event == "http_success" then
-- --         local content = h.readAll()
-- --         h.close()
-- --         local file = fs.open(name, 'w')
-- --         file.write(content)
-- --         file.close()
-- --         -- print("Saved " .. name .. ".lua")
-- --         -- http.request(repo .. name .. ".lua")
-- --         shell.run(name)
-- --     elseif event == "http_failure" then
-- --         -- print("Download fehlgeschlagen!")
-- --     end
-- -- end
-- -- math2 = math.random(1, 50000)
-- -- request = http.get(repo .. name .. ".lua?t=" .. os.time() .. math2)
-- -- print(math2)
-- -- print(request.readAll())
-- -- request.close()
-- local cacheBuster = ("%x"):format(math.random(0, 2 ^ 30))
-- -- local response, err = http.get(repo .. read() .. ".lua?cb=" .. cacheBuster, nil,
-- --                                true)
-- local response, err = http.get(repo .. name .. ".lua?cb=" .. cacheBuster, nil,
--                                true)
-- local sResponse = response.readAll()
-- response.close()
-- print(sResponse)
repo = "https://raw.githubusercontent.com/tretapolis-dev/computercraft/main/"
name = "test"
write("Connecting to " .. repo .. name .. ".lua ...")
local cacheBuster = ("%x"):format(math.random(0, 2 ^ 30))
local ok, err = http.checkURL(repo .. name .. ".lua?cb=" .. cacheBuster)
if not ok then
    print("Failed.")
    if err then printError(err) end
    return nil
end
response = http.get(repo .. name .. ".lua?cb=" .. cacheBuster, nil, true)
if not response then
    print("Failed.")
    return nil
end
print("Success.")
local sResponse = response.readAll()

for name, value in response do
    print(name)
    print(value)
end
response.close()
local sPath = shell.resolve(name)
if fs.exists(sPath) then fs.delete(sPath) end
if sResponse then
    local file = fs.open(sPath, "w")
    file.write(sResponse)
    file.close()
    print("Downloaded as " .. name)
    shell.run(name)
end

