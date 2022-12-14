-- Only highlight on keypress
vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}

-- Color config
local qsGrp = vim.api.nvim_create_augroup("qs_colors", { clear = true })
vim.api.nvim_create_autocmd("Colorscheme", {
    command = "* highlight QuickScopePrimary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline",
    -- command = "* highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline",
    group = qsGrp
})
vim.api.nvim_create_autocmd("Colorscheme", {
    command = "* highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline",
    group = qsGrp
})
