local addonName, sl = ...

Options = {};
Options.panel = CreateFrame( "Frame", "ShardLockPanel", UIParent );
-- Register in the Interface Addon Options GUI
-- Set the name for the Category for the Options Panel
Options.panel.name = "Shard Lock";

function Options.panel.okay(self)
  print("Shard Lock Updated!")
  shardInfo()
end

-- Add the panel to the Interface Options
InterfaceOptions_AddCategory(Options.panel);