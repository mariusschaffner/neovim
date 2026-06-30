vim.pack.add({
  { src = "https://github.com/jake-stewart/multicursor.nvim", version = "1.0" },
})

local mc = require("multicursor-nvim")
mc.setup()
local set = vim.keymap.set

set({ "n", "x" }, "<C-Up>", function() mc.lineAddCursor(-1) end)
set({ "n", "x" }, "<C-Down>", function() mc.lineAddCursor(1) end)
set({ "n", "x" }, "<A-Up>", function() mc.lineSkipCursor(-1) end)
set({ "n", "x" }, "<A-Down>", function() mc.lineSkipCursor(1) end)

mc.addKeymapLayer(function(layerSet)
  layerSet("n", "<esc>", function()
    if not mc.cursorsEnabled() then
      mc.enableCursors()
    else
      mc.clearCursors()
    end
  end)
end)

local hl = vim.api.nvim_set_hl
hl(0, "MultiCursorCursor", { reverse = true })
hl(0, "MultiCursorVisual", { link = "Visual" })
hl(0, "MultiCursorSign", { link = "SignColumn" })
hl(0, "MultiCursorMatchPreview", { link = "Search" })
hl(0, "MultiCursorDisabledCursor", { reverse = true })
hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
