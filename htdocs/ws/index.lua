require "string"

--[[
     This is the default method name for Lua handlers, see the optional
     function-name in the LuaMapHandler directive to choose a different
     entry point.
--]]

function dprint(msg)
    print(string.format("[%s] %s", os.date(), msg))
end

function handle(r)
    if r:wsupgrade() then -- if we can upgrade:
        r:wswrite("Welcome to websockets!") -- write something to the client

        -- Sleep while nothing is being sent to us...
        dprint("Loop start")
        while r:wspeek() == false do
           dprint("usleep")
           r.usleep(50000)
        end
        dprint("wspeek == true")

        -- We have data ready!
        local line = r:wsread()
        dprint(string.format("wsread: %s", line))

        dprint("wsclose")
        r:wsclose()  -- goodbye!
    end
end
