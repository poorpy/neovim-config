local M = {}

M.setup = function()
    local present1, cmp = pcall(require, "cmp")
    local present2, lspkind = pcall(require, "lspkind")
    local present3, luasnip = pcall(require, "luasnip")

    if not (present1 and present2 and present3) then
        return
    end

    local select_next_item = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        else
            fallback()
        end
    end, { "i", "s" })

    local select_prev_item = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        else
            fallback()
        end
    end, { "i", "s" })

    local jump_to_next = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
    end, { "i", "s" })

    local jump_to_prev = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { "i", "s" })

    cmp.setup({
        mapping = {
            ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
            ["<C-e>"] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),
            ["<CR>"] = cmp.mapping.confirm({ select = false }),
            ["<C-y>"] = cmp.config.disable,
            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
            ["<C-n>"] = select_next_item,
            ["<C-p>"] = select_prev_item,
            ["<C-j>"] = jump_to_next,
            ["<C-k>"] = jump_to_prev,
            ["<Tab>"] = select_next_item,
            ["<S-Tab>"] = select_prev_item,
            ["<Down>"] = select_next_item,
            ["<Up>"] = select_prev_item,
        },

        sources = {
            { name = "nvim_lua" },
            { name = "nvim_lsp" },
            { name = "path" },
            { name = "luasnip" },
            { name = "buffer", keyword_length = 3 },
            {
                name = "look",
                keyword_length = 5,
                max_item_count = 5,
                option = { convert_case = true, loud = true },
            },
            { name = "calc" },
            { name = "fish" },
            { name = "emoji" },
        },

        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },

        formatting = {
            format = lspkind.cmp_format({
                mode = "symbol_text",
                maxwidth = 50,
                menu = {
                    buffer = "[buf]",
                    calc = "[calc]",
                    emoji = "[emoji]",
                    fish = "[fish]",
                    look = "[look]",
                    luasnip = "[snip]",
                    nvim_lsp = "[lsp]",
                    nvim_lua = "[lua]",
                    path = "[path]",
                },
            }),
        },

        sorting = {
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.score,

                function(entry1, entry2)
                    local _, entry1_under = entry1.completion_item.label:find("^_+")
                    local _, entry2_under = entry2.completion_item.label:find("^_+")
                    entry1_under = entry1_under or 0
                    entry2_under = entry2_under or 0
                    if entry1_under > entry2_under then
                        return false
                    elseif entry1_under < entry2_under then
                        return true
                    end
                end,

                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },

        window = {
            -- completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },

        experimental = { native_menu = false, ghost_text = true },
    })
end

return M
