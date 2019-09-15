
-- Global Variables
soulShardID = 6265
maxShards = 5

Shard = {bag = 0, slot = 0}
function Shard:create (o)
  o.parent = self
  return o
end

-- Get Current Number of Soul Shards in all Bags
local function getShardCount()
  return GetItemCount(soulShardID)
end

-- Print Shard Lock Configuration
local function shardInfo()
  print("Soul Shards:",getShardCount()," Max:",maxShards)
end

-- Get Location of all Soul Shards
local function getShards()

  shards = {}
  for b = 0, 4 do
    for s = 1, GetContainerNumSlots(b) do 
      local l = GetContainerItemLink(b, s) 
      if l and l:find(soulShardID) then 
        table.insert(shards, Shard:create{bag = b, slot = s})
      end 
    end 
  end
  return shards

end

-- Remove Superfluous Soul Shards
local function rmSoulShards()

  numShards = getShardCount()
  if numShards <= maxShards then return end

  shards = getShards()
  for i = 1, numShards - maxShards do 
    print("Deleting Soul Shard")
    PickupContainerItem(shards[i].bag, shards[i].slot) 
    DeleteCursorItem()
  end

end

-- Set Maximum Number of Allowed Soul Shards in all Bags
local function setMaxShards(max)
  newMax = tonumber(max)
  if newMax == nil then 
    print(max,"is NOT a Number, Setting Max Soul Shards to", maxShards)
  else
    maxShards = newMax
    rmSoulShards()
  end
  shardInfo()
end

local function showHelp(args)
  print("Shard Lock Usage:")
  print("  Enable: /sl enable")
  print("  Show Help: /sl help")
  print("  Disable: /sl disable")
  print("  Get Shard Info: /sl info")
  print("  Set Max Soul Shards: /sl setmax <number>")
  shardInfo()
end

-- SLASH COMMANDS
local function slashCommands(msg, editbox)
  -- pattern matching that skips leading whitespace and whitespace between cmd and args
  -- any whitespace at end of args is retained
  local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")
   
  if cmd == "help" then
    showHelp()

  elseif cmd == "info"then
    shardInfo()

  elseif cmd == "disable" then
    DisableAddOn("ShardLock")
    print("Shard Lock Disabled")
    
  elseif cmd == "enable" then
    EnableAddOn("ShardLock")
    print("Shard Lock Enabled")

  elseif cmd == "setmax" and args ~= "" then
    setMaxShards(args)  

  elseif cmd == "rm" then
    rmSoulShards()

  else -- DEFAULT: display some sort of help message
    showHelp()
  end
end

SLASH_TIGHTLOCK1 = '/sl'
SlashCmdList["TIGHTLOCK"] = slashCommands


-- EVENTS
print("Shard Lock Loaded: /sl help")
shardInfo()

local frame, eventsFrame = CreateFrame("Frame"), {};

function eventsFrame:PLAYER_REGEN_ENABLED(...) -- Player Left Combat
  rmSoulShards();
end

-- Register Events Frame to OnEvent handler of Main Frame
frame:SetScript("OnEvent", function(self, event, ...)
 eventsFrame[event](self, ...); -- call one of the functions above
end);

-- Register all events for which handlers have been defined above
for k, v in pairs(eventsFrame) do
 frame:RegisterEvent(k);
end