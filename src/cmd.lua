local addonName, sl = ...

local function showHelp(args)
  print("Shard Lock Usage:")
  print("  Show Help: /sl help")
  print("  Enable: /sl enable")
  print("  Disable: /sl disable")
  print("  Configure: /sl config")
  print("  Print Shard Info: /sl info")
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

  elseif cmd == "config" then
    InterfaceOptionsFrame_OpenToCategory(Options.panel.name);
    -- Note: Call this function twice (in a row), 
    -- there is a bug in Blizzard's code which makes the first call (after login or /reload) fail. 
    -- It opens interface options, but not on the addon's interface options, just the default interface options. 
    InterfaceOptionsFrame_OpenToCategory(Options.panel.name);

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