-- Set LSP related keymaps on lsp attach
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp_keymaps', { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        local lmap = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
        end

        lmap('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
        lmap('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
        lmap('n', 'gr', vim.lsp.buf.references, 'Find references')
        lmap('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
        lmap('n', 'K', vim.lsp.buf.hover, 'Hover docs')
        lmap('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
        lmap('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
        lmap('n', '<leader>f', function()
            vim.lsp.buf.format({ async = true })
        end, 'Format buffer')

        -- Inlay hints
        if client and client:supports_method('textDocument/inlayHint', ev.buf) then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
            lmap('n', '<leader>th', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
            end, '[T]oggle inlay [H]ints')
        end
    end,
})

-- Highlight yanked text briefly for visual feedback
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Treat YAML files as Ansible YAML
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.yml", "*.yaml" },
    desc = "Set Ansible filetype for YAML files",
    group = vim.api.nvim_create_augroup("ansible-yaml", { clear = true }),
    callback = function()
        vim.bo.filetype = "yaml.ansible"
    end,
})
