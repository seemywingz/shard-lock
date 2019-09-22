local addonName, sl = ...

function sl.loadOptions ()
  sl.optionsPane = CreateFrame("Frame");
  sl.optionsPane.name = addonName
  InterfaceOptions_AddCategory(sl.optionsPane);
  
  local title = sl.optionsPane:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
  title:SetPoint("TOPLEFT", 16, -16)
  title:SetText(sl.optionsPane.name)
  
  local sliderMin = 1
  local sliderMax = 20
  sl.maxSlider = CreateFrame("Slider", "SL_MAX_SLIDER", sl.optionsPane, "OptionsSliderTemplate")
  sl.maxSlider:SetWidth(200)
  sl.maxSlider:SetHeight(30)
  sl.maxSlider:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -30)
  sl.maxSlider:SetOrientation('HORIZONTAL')
  sl.maxSlider:SetValue(SL_maxShards)
  sl.maxSlider:SetValueStep(1)
  sl.maxSlider:SetMinMaxValues(sliderMin,sliderMax);
  sl.maxSlider.tooltipText = 'Set Maximum Number of Soul Shards' --Creates a tooltip on mouseover.
  getglobal(sl.maxSlider:GetName() .. 'Low'):SetText(sliderMin); --Sets the left-side slider text (default is "Low").
  getglobal(sl.maxSlider:GetName() .. 'High'):SetText(sliderMax); --Sets the right-side slider text (default is "High").
  getglobal(sl.maxSlider:GetName() .. 'Text'):SetText('Max Shards: ' .. SL_maxShards); --Sets the "title" text (top-centre of slider).
  sl.maxSlider:Show()
  sl.maxSlider:SetScript("OnValueChanged", function(self,value)
    getglobal(sl.maxSlider:GetName() .. 'Text'):SetText('Max Shards: ' .. floor(value));
  end)
  sl.maxSlider:SetEnabled(true)
  
  function sl.optionsPane.okay()
    local newMax = floor(sl.maxSlider:GetValue())
    sl.setMaxShards(newMax)
  end

  function sl.optionsPane.refresh()
    sl.maxSlider:SetValue(SL_maxShards)
  end

end