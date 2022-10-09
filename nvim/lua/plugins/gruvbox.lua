vim.o.background = 'dark' -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

local keyset = vim.keymap.set
local isOn = false

local function toggleBackground()
  if isOn == false then
    vim.cmd([[highlight Normal guibg=none]])
    isOn = true
  else
    vim.cmd([[syntax reset]])
    isOn = false
  end
end

toggleBackground()

keyset('n', '<Leader>bg', toggleBackground)
