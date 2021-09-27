require "string"

--[[
     This is the default method name for Lua handlers, see the optional
     function-name in the LuaMapHandler directive to choose a different
     entry point.
--]]
function handle(r)
    if r:wsupgrade() then -- if we can upgrade:
        r:wswrite("Welcome to websockets!") -- write something to the client

        -- Sleep while nothing is being sent to us...
        while r:wspeek() == false do
           print("usleep")
           r.usleep(50000)
        end
        print("wspeek == true")

        -- We have data ready!
        local line = r:wsread()
        print(string.format("wsread: %s", line))

        print("wsclose")
        r:wsclose()  -- goodbye!
    end
end
