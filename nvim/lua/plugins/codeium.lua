local sources = nil
local codeiumSource = nil

local getCodiumToggle = function(enableNotification)
  return function()
    local cmp = require("cmp")

    if sources == nil then
      print("Codeium: error - sources == nil")
      return
    end

    local codeumSourceIndex = nil

    for i, value in ipairs(sources) do
      if value.name == "codeium" then
        codeumSourceIndex = i
      end
    end

    if codeumSourceIndex ~= nil then
      codeiumSource = sources[codeumSourceIndex]
      table.remove(sources, codeumSourceIndex)
      cmp.config.sources(sources)

      if enableNotification then
        print("Codeium: disabled")
      end
    elseif codeiumSource then
      table.insert(sources, codeiumSource)
      cmp.config.sources(sources)

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
    sources = opts.sources
    getCodiumToggle(false)()
  end,
  keys = {
    {
      "<leader>ct",
      getCodiumToggle(true),
      desc = "Codeium toggle",
    },
  },
}
