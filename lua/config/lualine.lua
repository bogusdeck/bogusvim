local custom_colors = {
    base = "#040a0c",
    mantle = "#061115",
    crust = "#78D6C6",
    subtext1 = "#bac2de",
    subtext0 = "#a6adc8",
    overlay2 = "#008170",
    overlay1 = "#04364A",
    overlay0 = "#419197",
    surface2 = "#2D9596",
    surface1 = "#176B87",
    surface0 = "#265073",
}

require('lualine').setup({
    options = {
        theme = {
            normal = {
                a = { fg = custom_colors.base, bg = custom_colors.overlay2, gui = 'bold' },
                b = { fg = custom_colors.subtext1, bg = custom_colors.surface1 },
                c = { fg = custom_colors.subtext0, bg = custom_colors.mantle },
            },
            insert = {
                a = { fg = custom_colors.base, bg = custom_colors.overlay0, gui = 'bold' },
                b = { fg = custom_colors.subtext1, bg = custom_colors.surface0 },
                c = { fg = custom_colors.subtext0, bg = custom_colors.mantle },
            },
            visual = {
                a = { fg = custom_colors.base, bg = custom_colors.surface2, gui = 'bold' },
                b = { fg = custom_colors.subtext1, bg = custom_colors.surface1 },
                c = { fg = custom_colors.subtext0, bg = custom_colors.mantle },
            },
            replace = {
                a = { fg = custom_colors.base, bg = custom_colors.crust, gui = 'bold' },
                b = { fg = custom_colors.subtext1, bg = custom_colors.surface0 },
                c = { fg = custom_colors.subtext0, bg = custom_colors.mantle },
            },
            inactive = {
                a = { fg = custom_colors.overlay1, bg = custom_colors.mantle, gui = 'bold' },
                b = { fg = custom_colors.subtext0, bg = custom_colors.surface0 },
                c = { fg = custom_colors.subtext1, bg = custom_colors.base },
            },
        },
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
})
