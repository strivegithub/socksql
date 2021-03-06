-- cclog
cclog = function(...)
    print(string.format(...))
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    local err = "LUA ERROR: " .. tostring(msg) .. "\n"
    err = err..debug.traceback()
    cclog(err)
    cclog("----------------------------------------")
    sendReq('synError', dict({{"error", err}})) 
end

OldPrint = print
function print(...)
    --if DEBUG then
        OldPrint(...)
    --end
end


local function main()
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    ---------------
    require "Global.INCLUDE"
    --require "Miao.Logic"
    --require "Miao.MiaoScene"
    --require "Miao.TMXScene"

    --require "myMap.MapScene"
    --require 'Miao.FightScene'
    --require 'myMap.FightMap'
    --require "Miao.TestSea"
    --require "TestScene"
    require "SocScene"

    for k, v in pairs(package.preload) do
        print(k, v)
    end

    local director = CCDirector:sharedDirector()

    --[[
    local sc = TMXScene.new()
    director:replaceScene(sc.bg)
    global.director:onlyRun(sc)
    --]]
    local sc = SocScene.new()
    --director:runWithScene(sc.bg)
    --global.director:onlyRun(sc)
    global.director:runWithScene(sc)
    
    --[[
    local sc = FightScene.new()
    director:replaceScene(sc.bg)
    global.director:onlyRun(sc)
    --]]

    --[[
    local sc = FightMap.new()
    director:replaceScene(sc.bg)
    global.director:onlyRun(sc)
    --]]

    --require "Menu.TestMenu"
    --global.director:runWithScene(TestMenu.new())
    
    --global.director:runWithScene(MapScene.new())

end

xpcall(main, __G__TRACKBACK__)
