-- settings
repo = "https://raw.githubusercontent.com/tretapolis-dev/computercraft/main/"
name = "test"
erfolg = true
-- -
print("Downloading " .. name .. ".lua ...")
http.request(repo .. name .. ".lua")
local loop = true
while loop do
    local event, url, h = os.pullEvent()
    if event == "http_success" then
        local content = h.readAll()
        h.close()
        local file = fs.open(name, 'w')
        file.write(content)
        file.close()
        print("Saved " .. name .. ".lua")
        loop = false
    elseif event == "http_failure" then
        print("Download fehlgeschlagen!")
        loop = false
        erfolg = false
    end
end
if erfolg == true then shell.run(name) end
