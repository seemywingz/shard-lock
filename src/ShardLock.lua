local addonName, sl = ...

sl.soulShardID = 6265
SL_maxShards = 5

sl.Shard = {bag = 0, slot = 0}
function sl.Shard:create (o)
  o.parent = self
  return o
end

-- Get Current Number of Soul Shards in all Bags
function sl.getShardCount()
  return GetItemCount(sl.soulShardID)
end

-- Get Location of all Soul Shards
function sl.getShards()

  shards = {}
  for b = 0, 4 do
    for s = 1, GetContainerNumSlots(b) do 
      local l = GetContainerItemLink(b, s) 
      if l and l:find(sl.soulShardID) then 
        table.insert(shards, sl.Shard:create{bag = b, slot = s})
      end 
    end 
  end
  return shards

end

-- Print Shard Lock Configuration
function sl.shardInfo()
  shards = sl.getShards()
  print("Soul Shards:",table.getn(shards)," Max:",SL_maxShards)
end

-- Remove Superfluous Soul Shards
function sl.rmSoulShards()

  numShards = sl.getShardCount()
  if numShards <= SL_maxShards then return end

  shards = sl.getShards()
  for i = 1, numShards - SL_maxShards do 
    print("Deleting Soul Shard")
    PickupContainerItem(shards[i].bag, shards[i].slot) 
    DeleteCursorItem()
  end

end

-- Set Maximum Number of Allowed Soul Shards in all Bags
function sl.setMaxShards(max)
  newMax = tonumber(max)
  if newMax == nil then 
    print(max,"is NOT a Number, Setting Max Soul Shards to", SL_maxShards)
  else
    SL_maxShards = newMax
    print("Max Soul Shards:", SL_maxShards)
    sl.rmSoulShards()
  end
end
