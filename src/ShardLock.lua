local addonName, sl = ...

-- Global Variables
soulShardID = 6265
maxShards = 5

Shard = {bag = 0, slot = 0}
function Shard:create (o)
  o.parent = self
  return o
end

-- Get Current Number of Soul Shards in all Bags
function getShardCount()
  return GetItemCount(soulShardID)
end

-- Print Shard Lock Configuration
function shardInfo()
  print("Soul Shards:",getShardCount()," Max:",maxShards)
end

-- Get Location of all Soul Shards
function getShards()

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
function rmSoulShards()

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
function setMaxShards(max)
  newMax = tonumber(max)
  if newMax == nil then 
    print(max,"is NOT a Number, Setting Max Soul Shards to", maxShards)
  else
    maxShards = newMax
    rmSoulShards()
  end
  shardInfo()
end
