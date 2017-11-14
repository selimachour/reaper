
-- removes a line of fx on every track but the master

nbTracks = reaper.CountTracks(0)

for trackidx = 0, nbTracks-1 do 

    tr = reaper.GetTrack(0, trackidx)
    fxCount = reaper.TrackFX_GetCount(tr)
     
    reaper.SNM_MoveOrRemoveTrackFX(tr, 0, 0)

end
