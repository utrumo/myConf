-- Алиас для быстрого доступа к методу установки горячих клавиш
local map = vim.api.nvim_set_keymap
local keyset = vim.keymap.set

--[[
Метод для установки горячих клавиш (normal)
key - {string} Строка с горячей клавишей
command - {string} Команда
]]
--
function nm(key, command) map('n', key, command, { noremap = true }) end

function nmCb(key, cb) keyset('n', key, cb, { noremap = true }) end

--[[
Метод для установки горячих клавиш (input)
key - {string} Строка с горячей клавишей
command - {string} Команда
]]
--
function im(key, command) map('i', key, command, { noremap = true }) end

--[[
Метод для установки горячих клавиш (visual)
key - {string} Строка с горячей клавишей
command - {string} Команда
]]
--
function vm(key, command) map('v', key, command, { noremap = true }) end

--[[
Метод для установки горячих клавиш (terminal)
key - {string} Строка с горячей клавишей
command - {string} Команда
]]
--
function tm(key, command) map('t', key, command, { noremap = true }) end

local M = {}

M.printInspect = function (value) print(vim.inspect(value)) end

return M
