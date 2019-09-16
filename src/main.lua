local addonName, sl = ...

-- EVENTS
local frame, eventsFrame = CreateFrame("Frame"), {};

function eventsFrame:PLAYER_REGEN_ENABLED(...) -- Player Left Combat
  rmSoulShards();
end

function eventsFrame:VARIABLES_LOADED(...) -- Addon and Saved Vars Loaded
  print("Shard Lock Loaded: /sl help")
  loadOptions()
  shardInfo();
end

-- Register Events Frame to OnEvent handler of Main Frame
frame:SetScript("OnEvent", function(self, event, ...)
 eventsFrame[event](self, ...); -- call one of the functions above
end);

-- Register all events for which handlers have been defined above
for k, v in pairs(eventsFrame) do
 frame:RegisterEvent(k);
end