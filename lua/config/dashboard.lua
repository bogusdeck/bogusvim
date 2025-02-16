local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Your Custom ASCII Logo
dashboard.section.header.val = {
  "██████╗  ██████╗  ██████╗ ██╗   ██╗███████╗██████╗ ███████╗ ██████╗██╗  ██╗",
  "██╔══██╗██╔═══██╗██╔════╝ ██║   ██║██╔════╝██╔══██╗██╔════╝██╔════╝██║ ██╔╝",
  "██████╔╝██║   ██║██║  ███╗██║   ██║███████╗██║  ██║█████╗  ██║     █████╔╝ ",
  "██╔══██╗██║   ██║██║   ██║██║   ██║╚════██║██║  ██║██╔══╝  ██║     ██╔═██╗ ",
  "██████╔╝╚██████╔╝╚██████╔╝╚██████╔╝███████║██████╔╝███████╗╚██████╗██║  ██╗",
  "╚═════╝  ╚═════╝  ╚═════╝  ╚═════╝ ╚══════╝╚═════╝ ╚══════╝ ╚═════╝╚═╝  ╚═╝",
}

-- Optional: Customize footer if you want
dashboard.section.footer.val = {
  "Happy Coding, -Tanish!"
}

-- Apply the dashboard configuration
alpha.setup(dashboard.config)
