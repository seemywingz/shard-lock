local name, sl = ...

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