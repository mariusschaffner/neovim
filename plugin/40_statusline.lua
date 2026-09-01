local function get_mode()
    local mode_map = {
        n = { " n ", "StModeNormal" },
        i = { " i ", "StModeInsert" },
        v = { " v ", "StModeVisual" },
        V = { " v-line ", "StModeVisual" },
        ["\22"] = { " v-block ", "StModeVisual" },
        c = { " c ", "StModeOther" },
        r = { " r ", "StModeOther" },
        R = { " R ", "StModeOther" },
        t = { " t ", "StModeOther" },
    }
    local mode = vim.api.nvim_get_mode().mode
    local m = mode_map[mode] or { " " .. mode .. " ", "StModeOther" }
    return "%#" .. m[2] .. "#" .. m[1] .. "%#StBase#"
end

local function get_git()
    local dict = vim.b.gitsigns_status_dict
    if not dict then
        return ""
    end

    local branch = dict.head and ("%#StGitBranch#  " .. dict.head .. " ") or ""
    local added = dict.added and dict.added > 0 and ("%#StGitAdd#+" .. dict.added .. " ") or ""
    local changed = dict.changed and dict.changed > 0 and ("%#StGitChange#~" .. dict.changed .. " ") or ""
    local removed = dict.removed and dict.removed > 0 and ("%#StGitDelete#-" .. dict.removed .. " ") or ""

    local diff = added .. changed .. removed
    if branch == "" and diff == "" then
        return ""
    end
    return branch .. diff .. ""
end

local function get_lsp_diagnostic_count()
    local counts = vim.diagnostic.count(0)

    local errors = counts[vim.diagnostic.severity.ERROR] or 0
    local warnings = counts[vim.diagnostic.severity.WARN] or 0
    local hints = counts[vim.diagnostic.severity.HINT] or 0
    local info = counts[vim.diagnostic.severity.INFO] or 0

    local error_icon = errors > 0 and "  " .. errors or ""
    local warnings_icon = warnings > 0 and "  " .. warnings or ""
    local hints_icon = hints > 0 and "  " .. hints or ""
    local info_icon = info > 0 and "  " .. info or ""

    return "%#ErrorHl#"
        .. error_icon
        .. "%#WarningHl#"
        .. warnings_icon
        .. "%#HintsHl#"
        .. hints_icon
        .. "%#InfoHl#"
        .. info_icon
end

local has_devicons, devicons = pcall(require, "nvim-web-devicons")
local function get_icon()
    if not has_devicons then
        return ""
    end
    local icon, icon_hl = devicons.get_icon(vim.fn.expand("%:t"), vim.fn.expand("%:e"))
    if not icon then
        return ""
    end
    return "%#" .. icon_hl .. "# " .. icon .. " %#StBase#"
end

local blink_icon = true
local blink_timer = nil

local function get_macro_reading()
    local is_rec = vim.fn.reg_recording()
    if is_rec == "" then
        if blink_timer then
            blink_timer:stop()
            blink_timer:close()
            blink_timer = nil
        end
        return ""
    end
    if not blink_timer then
        blink_timer = vim.uv.new_timer()
        blink_timer:start(
            0,
            500,
            vim.schedule_wrap(function()
                blink_icon = not blink_icon
                vim.cmd("redrawstatus")
            end)
        )
    end
    local icon = blink_icon and "" or " "
    return "%#RecordingHl#" .. icon .. "%#StBase#" .. " Rec @"
end

function _G.CustomStatusLine()
    local is_active = vim.g.statusline_winid == vim.fn.win_getid()
    local is_modified = vim.api.nvim_get_option_value("modified", { buf = 0 })
    local modified_icon = is_modified and "●" or ""
    local filename = " %t"
    local space = "%="
    if not is_active then
        return "%#StBase#" .. filename .. space
    end
    return "%#StBase# "
        .. "%#StBase#"
        .. get_mode()
        .. filename
        .. " "
        .. get_lsp_diagnostic_count()
        .. get_git()
        .. "%#StBase#"
        .. space
        .. get_macro_reading()
        .. space
        .. get_icon()
end

vim.opt.statusline = "%!v:lua.CustomStatusLine()"

vim.cmd("redrawstatus")

vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave", "CmdlineLeave" }, {
    callback = function()
        vim.schedule(function()
            vim.cmd("redrawstatus")
        end)
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = { "GitSignsUpdate" },
    callback = function()
        vim.cmd("redrawstatus")
    end,
})
