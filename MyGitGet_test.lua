-- pastebin get 9wFXXLWx testpull
shell.run("clear")
-- settings
repo = "https://raw.githubusercontent.com/tretapolis-dev/computercraft/main/"
name = "test"
if fs.exists(name) == true then fs.delete(name) end
-- -
-- print("Downloading " .. name .. ".lua ...")
finish = true
http.request(repo .. name .. ".lua")
while finish do
    local event, url, h = os.pullEvent()
    if event == "http_success" then
        local content = h.readAll()
        h.close()
        local file = fs.open(name, 'w')
        file.write(content)
        file.close()
        -- print("Saved " .. name .. ".lua")
        http.request(repo .. name .. ".lua")
        finish = false
        shell.run(name)
    elseif event == "http_failure" then
        finish = false
        -- print("Download fehlgeschlagen!")
    end
end
