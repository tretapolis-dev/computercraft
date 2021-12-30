-- -- pastebin get 9wFXXLWx testpull
-- shell.run("clear")
-- -- settings
repo = "https://raw.githubusercontent.com/tretapolis-dev/computercraft/main/"
name = "test"
-- if fs.exists(name) == true then fs.delete(name) end
-- -- -
-- -- print("Downloading " .. name .. ".lua ...")
-- http.request(repo .. name .. ".lua", nil, {os.time()})
-- while true do
--     local event, url, h = os.pullEvent()
--     if event == "http_success" then
--         local content = h.readAll()
--         h.close()
--         local file = fs.open(name, 'w')
--         file.write(content)
--         file.close()
--         -- print("Saved " .. name .. ".lua")
--         -- http.request(repo .. name .. ".lua")
--         shell.run(name)
--     elseif event == "http_failure" then
--         -- print("Download fehlgeschlagen!")
--     end
-- end
request = http.get(repo .. name .. ".lua?t=" .. os.time())
print(request.readAll())
request.close()
