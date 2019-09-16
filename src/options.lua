local addonName, sl = ...

function loadOptions ()
  options = CreateFrame( "Frame");
  options.name = addonName
  InterfaceOptions_AddCategory(options);
  
  local title = options:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
  title:SetPoint("TOPLEFT", 16, -16)
  title:SetText(options.name)
  
  -- local maxText = options:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  -- maxText:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
  -- maxText:SetText("Max Shards")
  
  local maxSlider = CreateFrame("Slider", "SL_MAX_SLIDER", options, "OptionsSliderTemplate")
  local sliderMin = 1
  local sliderMax = 20
  maxSlider:SetWidth(200)
  maxSlider:SetHeight(30)
  maxSlider:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -30)
  maxSlider:SetOrientation('HORIZONTAL')
  maxSlider:SetValue(maxShards)
  maxSlider:SetValueStep(1)
  maxSlider:SetMinMaxValues(sliderMin,sliderMax);
  maxSlider.tooltipText = 'Set Maximum Number of Soul Shards' --Creates a tooltip on mouseover.
  getglobal(maxSlider:GetName() .. 'Low'):SetText(sliderMin); --Sets the left-side slider text (default is "Low").
  getglobal(maxSlider:GetName() .. 'High'):SetText(sliderMax); --Sets the right-side slider text (default is "High").
  getglobal(maxSlider:GetName() .. 'Text'):SetText('Max Shards: ' .. maxShards); --Sets the "title" text (top-centre of slider).
  maxSlider:SetEnabled(true)
  maxSlider:Show()
  maxSlider:SetScript("OnValueChanged", function(self,value)
    getglobal(maxSlider:GetName() .. 'Text'):SetText('Max Shards: ' .. floor(value));
  end)
  
  
  function options.okay(self)
    print("!! Shard Lock Updated !!")
    local newMax = floor(maxSlider:GetValue())
    setMaxShards(newMax)
  end

end