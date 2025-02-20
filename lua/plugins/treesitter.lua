return {
    -- Treesitter Core
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            ensure_installed = {
                "astro", "cmake", "cpp", "css", "fish", "gitignore", "go",
                "graphql", "http", "java", "php", "rust", "scss", "sql",
                "svelte", "python", "rst", "toml", "ninja"
            },
            highlight = { enable = true },
            indent = { enable = true },

            -- Query Linter
            query_linter = {
                enable = true,
                use_virtual_text = true,
                lint_events = { "BufWrite", "CursorHold" },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)

            -- MDX Support
            vim.filetype.add({ extension = { mdx = "mdx" } })
            vim.treesitter.language.register("markdown", "mdx")
        end,
    },
}
