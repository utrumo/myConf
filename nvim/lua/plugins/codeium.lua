return {
  "nvim-cmp",
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local source = nil

    for _key, value in pairs(opts.sources) do
      if value.name == "codeium" then
        source = value
      end
    end

    local priority = 1

    if source then
      source.priority = priority
    else
      table.insert(opts.sources, 1, {
        name = "codeium",
        group_index = 1,
        priority = priority,
      })
    end
  end,
}
