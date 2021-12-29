-- links oben Fuel > fackeln > chedst fuel > Testchest fackeln  >CHEST Miningmaterial> cobblestonetest
tunnelabstand = 1
torchabstand = 1
refuelTorches = true
refuelFuel = true
length = -1
height = 3
tunnels = 0
x = 0
y = 0
z = 0
rotate = 0
initval = true
function returnToStart()
    left(2)
    move(x)
    left(2)
    heightReturn()
    emptyTurtel(true)
end

function check()
    slots = 0
    for i = 6, 16, 1 do
        if turtle.getItemCount(i) == 0 then slots = slots + 1 end
    end
    if slots <= 2 then emptyTurtel(false) end
    if turtle.getFuelLevel() <= 50 then refuel(true) end
end

function run()
    if length == -1 then
        term.setTextColor(colors.red)
        print("")
        write(
            "Möchtest du das Turtel ohne längenbegrenzung starten? (J/N): [N] ")
        term.setTextColor(colors.white)
        if string.upper(read()) ~= "J" then
            shell.run("clear")
            term.setTextColor(colors.red)
            print("Programmabbruch durch den USER!")
            print("")
            print("")
            term.setTextColor(colors.white)
            init(true)
        end
        while length <= 0 do
            move()
            x = x + 1
            mineheight()
            if refuelTorches == true and torchabstand == 7 then
                refuelTorch()
                torchabstand = 1
            end
            torchabstand = torchabstand + 1
            if tunnels > 0 and tunnelabstand == 4 then
                left()
                for currentTunnel = 1, tunnels, 1 do
                    move()
                    mineheight()
                end
                right(2)
                move(tunnels)
                for currentTunnel = 1, tunnels, 1 do
                    move()
                    mineheight()
                end
                left(2)
                move(tunnels)
                right()
                tunnelabstand = 1
            end
            tunnelabstand = tunnelabstand + 1
        end
    else
        for currentLength = 1, length, 1 do
            move()
            x = x + 1
            mineheight()
            if refuelTorches == true and torchabstand == 7 then
                refuelTorch()
                torchabstand = 1
            end
            torchabstand = torchabstand + 1
            if tunnels > 0 and tunnelabstand == 4 then
                left()
                for currentTunnel = 1, tunnels, 1 do
                    move()
                    mineheight()
                end
                right(2)
                move(tunnels)
                for currentTunnel = 1, tunnels, 1 do
                    move()
                    mineheight()
                end
                left(2)
                move(tunnels)
                right()
                tunnelabstand = 1
            end
            tunnelabstand = tunnelabstand + 1
        end
        returnToStart()
    end
end
function mineheight()
    if initval == true then
        if height == 1 then
            return
        elseif height == 2 then
            check()
            turtle.digUp()
        elseif height == 3 then
            moveUp()
            y = y + 1
        end
        initval = false
    end
    if initval == false then
        if height == 1 then
            return
        elseif height == 2 then
            check()
            turtle.digUp()
        elseif height == 3 then
            turtle.digDown()
            turtle.digUp()
        end
    end
end

function moveUp(times, checked)
    times = times or 1
    for variable = 1, times, 1 do
        if checked ~= true then check() end
        turtle.digUp()
        turtle.up()
    end
end
function moveDown(times)
    times = times or 1
    for variable = 1, times, 1 do
        check()
        turtle.digDown()
        turtle.down()
    end
end
function heightReturn()
    if y < 0 then
        moveUp(y * -1)
    elseif y > 0 then
        moveDown(y)
    elseif y == 0 then
        return
    end
end
function move(times)
    times = times or 1
    for variable = 1, times, 1 do
        check()
        turtle.dig()
        turtle.forward()
    end
end
function left(times)
    times = times or 1
    for variable = 1, times, 1 do turtle.turnLeft() end
end
function right(times)
    times = times or 1
    for variable = 1, times, 1 do turtle.turnRight() end
end
function floor()
    turtle.select(6)
    turtle.placeDown()
end
function torch(place)
    turtle.select(2)
    if turtle.getItemCount() <= 1 then
        print("Fackeln auffüllen ...")
        refuelTorch()
    end
    floor()
    moveUp()
    turtle.select(2)
    turtle.placeDown()
    move()
    moveDown()
    floor()
end
function emptyTurtel(place)
    print("entleeren...")
    if place == true then moveUp(1, true) end
    turtle.select(5)
    turtle.placeDown()
    for variable = 7, 16, 1 do
        turtle.select(variable)
        turtle.dropDown()
    end
    turtle.select(5)
    if place == true then
        moveDown()
    else
        turtle.digDown()
    end

end
function refuelTorch(place)
    if refuelTorches == false then return end
    if turtle.getItemCount(2) <= 1 then
        print("")
        print("Fackelvorrat auffüllen ...")
        if place == true then moveUp() end
        turtle.select(4)
        turtle.placeDown()
        turtle.select(2)
        turtle.suckDown(turtle.getItemSpace())
        turtle.select(4)
        if place == true then
            moveDown()
        else
            turtle.digDown()
        end
        print("")
        print("")
        print("Befüllung abgeschlossen...")
    end
    turtle.select(2)
    turtle.placeDown()
end
function refuel(place)
    if refuelFuel == false then return end
    firstFill = false
    if turtle.getFuelLevel() <= 0 then
        print("Grundbefüllung wird gestartet ...")
        turtle.digDown()
        firstFill = true
    end
    if turtle.getItemCount(1) >= 10 then return end
    print("")
    print("Kraftstoffvorrat auffüllen ...")
    if place == true then moveUp() end

    turtle.select(3)
    turtle.placeDown()
    turtle.select(1)
    turtle.suckDown(turtle.getItemSpace())
    while turtle.getFuelLevel() <= (turtle.getFuelLimit() - 500) do
        print("Kraftstoff einfüllen ...")
        turtle.refuel()
        print("Kraftstoff: ", turtle.getFuelLevel())
        print("Kraftstoffvorrat auffüllen ...")
        turtle.suckDown(turtle.getItemSpace())
    end
    print("")
    print("")
    turtle.select(3)
    if firstFill == true then
        turtle.digDown()
    else
        if place == true then
            moveDown()
        else
            turtle.digDown()
        end
    end
    print("Befüllung abgeschlossen...")
end
function init(restart)
    if restart == true then
        term.setTextColor(colors.green)
        print("Miner by TRETAPOLIS")
        print("")
        term.setTextColor(colors.white)
    else
        shell.run("clear")
        term.setTextColor(colors.green)
        print("Miner by TRETAPOLIS")
        print("")
        term.setTextColor(colors.white)
    end
    print("")
    write("Länge des Tunnels (Blöcke): [-1] ")
    local input = read()
    if input ~= "" then length = input end
    print("")
    write("Höhe des Tunnels (Blöcke 1-3): [3] ")
    local input = read()
    if input ~= "" then height = input end
    print("")
    write("Seitentunnel anlegen? (Blöcke): [0] ")
    local input = read()
    if input ~= "" then tunnels = tonumber(input) end
    print("")
    write("Kraftstoff auffüllen? (J/N): [J] ")
    if string.upper(read()) == "N" then refuelFuel = false end
    print("")
    write("Fackeln platzieren? (J/N): [J] ")
    if string.upper(read()) == "N" then refuelTorches = false end
    print(length, height, tunnels, refuelFuel, refuelTorches)
    refuel(true)
    refuelTorch(true)
    run()
end

init()
