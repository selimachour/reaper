-- ----------------------------------------------
--
-- Lua plugin for Cockos Reaper
--
-- Script for finding source files that might
-- have been encoded in flac or moved to 
-- the Audio Files folder
--
-- ----------------------------------------------


reaper.ShowConsoleMsg("")

nbItems = reaper.CountMediaItems(0)

for itemIdx = 0, nbItems-1 do 

    item = reaper.GetMediaItem(0, itemIdx)

    nbTakes = reaper.GetMediaItemNumTakes(item)

    if nbTakes > 0 then
        for takeIdx = 0, nbTakes-1 do
            take = reaper.GetTake(item, takeIdx)
            if (take ~= nil) and (not reaper.TakeIsMIDI(take)) then
                reaper.ShowConsoleMsg("Take [" .. tostring(itemIdx+1) .. "/" .. tostring(takeIdx+1) .. "] ")
                
                pcmSource = reaper.GetMediaItemTake_Source(take)
                filename = reaper.GetMediaSourceFileName(pcmSource, "")

                if reaper.file_exists(filename) then
                    reaper.ShowConsoleMsg(" [ok]")
                else
                    reaper.ShowConsoleMsg(" [not ok]")
                    flacname = string.gsub(filename, 'wav$', "flac")
                    flacdirname = string.gsub(flacname, '\\([^\\]+)$', "\\Audio Files\\%1")
                    filedirname = string.gsub(filename, '\\([^\\]+)$', "\\Audio Files\\%1")

                    if reaper.file_exists(flacname) then
                        reaper.ShowConsoleMsg(" [falc found]")
                        reaper.SetMediaItemTake_Source(take, reaper.PCM_Source_CreateFromFile(flacname))
                    elseif reaper.file_exists(flacdirname) then
                        reaper.ShowConsoleMsg(" [falc found in Audio Files]")
                        reaper.SetMediaItemTake_Source(take, reaper.PCM_Source_CreateFromFile(flacdirname))
                    elseif reaper.file_exists(filedirname) then
                        reaper.ShowConsoleMsg(" [in Audio Files]")
                        reaper.SetMediaItemTake_Source(take, reaper.PCM_Source_CreateFromFile(filedirname))
                    end 

                end
                
                reaper.ShowConsoleMsg("\n")
            end
        end
    end        
end
