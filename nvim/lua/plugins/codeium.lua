local cmpSources = nil
local codeiumSource = nil

local getToggleCodiumToggle = function(enableNotification)
  return function()
    local cmp = require("cmp")

    if cmpSources == nil then
      print("Error: cmpSources == nil")
      return
    end

    local codeumSourceIndex = nil

    for i, value in ipairs(cmpSources) do
      if value.name == "codeium" then
        codeumSourceIndex = i
      end
    end

    if codeumSourceIndex ~= nil then
      codeiumSource = cmpSources[codeumSourceIndex]
      table.remove(cmpSources, codeumSourceIndex)
      cmp.config.sources(cmpSources)

      if enableNotification then
        print("Codeium: disabled")
      end
    elseif codeiumSource then
      table.insert(cmpSources, codeiumSource)
      cmp.config.sources(cmpSources)

      if enableNotification then
        print("Codeium: enabled")
      end
    end
  end
end

return {
  "nvim-cmp",
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    cmpSources = opts.sources
    getToggleCodiumToggle(false)()
  end,
  keys = {
    {
      "<leader>ct",
      getToggleCodiumToggle(true),
      desc = "Codeium toggle",
    },
  },
}
