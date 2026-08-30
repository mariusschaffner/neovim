vim.pack.add({
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/esmuellert/codediff.nvim" },
    { src = "https://github.com/MunifTanjim/nui.nvim" },
    { src = "https://github.com/NeogitOrg/neogit" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/folke/snacks.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/emrearmagan/atlas.nvim" },
})

require("gitsigns").setup({
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
})

require("codediff").setup({
    keymaps = {
        view = {
            quit = "q",
            toggle_explorer = "<leader>b",
            next_hunk = "]c",
            prev_hunk = "[c",
            next_file = "<Tab>",
            prev_file = "<S-Tab>",
        },
        explorer = {
            select = "<CR>",
            hover = "K",
            refresh = "R",
        },
    },
})

local function current_gitlab_project()
    local remote = vim.fn.systemlist("git config --get remote.origin.url")[1]
    if not remote or remote == "" then
        return nil
    end

    local path = remote:match("^git@[^:]+:(.+)$")

    if not path then
        path = remote:match("^https?://[^/]+/(.+)$")
    end

    if not path then
        return nil
    end

    return (path:gsub("%.git$", ""))
end

local project = current_gitlab_project()

local pulls_views = {
    { name = "Assigned to Me", key = "1", order_by = "updated_at", state = "open", scope = "assigned_to_me", project = project },
    { name = "Reviewing",      key = "2", order_by = "updated_at", state = "open", scope = "all",            project = project, extra_params = { reviewer_id = "133" } },
    { name = "Open",           key = "3", order_by = "updated_at", state = "open", project = project },
}

require("atlas").setup({
    pulls = {
        diff = {
            open_cmd = "AtlasDiff",
            layout = "inline",
            compact = false,
            explorer = {
                hidden = false,
                show_commits = true,
            },
        },
        providers = {
            gitlab = {
                base_url = "https://gitlab.vertec.com",
                token = vim.env.GITLAB_TOKEN,
                cache_ttl = 300,
                views = pulls_views,
            },
        },
    },
    issues = {
        providers = {
            gitlab = {
                base_url = "https://gitlab.vertec.com",
                token = vim.env.GITLAB_TOKEN,
                cache_ttl = 300,
                views = {
                    -- { name = "Assigned to Me", key = "1", scope = "assigned_to_me", state = "opened", order_by = "updated_at" },
                    { name = "WF:Doing",      key = "2", scope = "assigned_to_me", state = "opened", order_by = "updated_at", extra_params = { labels = "WF:Doing" } },
                    { name = "WF:Review",     key = "3", scope = "assigned_to_me", state = "opened", order_by = "updated_at", extra_params = { labels = "WF:Review" } },
                    { name = "WF:Deployment", key = "4", scope = "assigned_to_me", state = "opened", order_by = "updated_at", extra_params = { labels = "WF:Deployment" } },
                    { name = "All",           key = "5", scope = "all",            state = "opened", order_by = "updated_at" },
                },
            },
        },
    },
})

require("neogit").setup({
    graph_style = "unicode",
    sections = {
        recent = {
            folded = false,
        },
    },
})

vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "[G]it Neogit UI" })
