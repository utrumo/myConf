-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "zipfile:/[^/]*",
  callback = function(args)
    -- the uri is like zipfile:/a/b/c
    local uri = args.match --[[@as string]]
    -- transform it to be zipfile:///a/b/c
    vim.fn["zip#Read"](uri:gsub("^zipfile:", "zipfile://"), 1)
    local printInspect = function(value)
      print(vim.inspect(value))
    end
    printInspect(uri)
  end,
})
