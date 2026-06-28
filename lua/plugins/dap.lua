return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local uv = vim.uv or vim.loop

      local function executable_or(name, fallback)
        local path = vim.fn.exepath(name)
        if path ~= "" then
          return path
        end
        if fallback and vim.fn.executable(fallback) == 1 then
          return fallback
        end
        return name
      end

      local function free_port()
        local tcp = assert(uv.new_tcp())
        assert(tcp:bind("127.0.0.1", 0))
        local port = tcp:getsockname().port
        tcp:close()
        return port
      end

      local codemap_output_path = vim.fn.expand("~/Projects/leet/output.txt")
      dapui.register_element("codemap_output", {
        render = function()
          if vim.fn.filereadable(codemap_output_path) == 0 then
            vim.fn.writefile({}, codemap_output_path)
          end
        end,
        buffer = function()
          if vim.fn.filereadable(codemap_output_path) == 0 then
            vim.fn.writefile({}, codemap_output_path)
          end

          local buf = vim.fn.bufadd(codemap_output_path)
          vim.fn.bufload(buf)
          vim.bo[buf].swapfile = false
          vim.bo[buf].filetype = "codemap_output"
          return buf
        end,
      })

      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.34 },
              { id = "breakpoints", size = 0.33 },
              { id = "stacks", size = 0.33 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "codemap_output", size = 0.5 },
            },
            size = 10,
            position = "bottom",
          },
        },
      })

      vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DapStopped", { text = ">", texthl = "DiagnosticSignWarn" })

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end

      -- Go uses Delve's native DAP server.
      local dlv = executable_or("dlv", vim.fn.expand("~/go/bin/dlv"))
      dap.adapters.go = function(callback, _)
        local port = free_port()
        local log_path = vim.fn.stdpath("cache") .. "/dlv-dap.log"
        local cmd = {
          dlv,
          "dap",
          "--listen=127.0.0.1:" .. port,
          "--log",
          "--log-output=dap,debugger",
          "--log-dest=" .. log_path,
        }

        local job = vim.fn.jobstart(cmd, {
          detach = true,
          on_stderr = function(_, data)
            data = data or {}
            local lines = vim.tbl_filter(function(line)
              return line and line ~= ""
            end, data)
            if #lines > 0 then
              vim.notify(table.concat(lines, "\n"), vim.log.levels.ERROR, { title = "Delve" })
            end
          end,
        })

        if job <= 0 then
          vim.notify("Failed to start Delve: " .. dlv, vim.log.levels.ERROR, { title = "DAP Go" })
          return
        end

        vim.defer_fn(function()
          callback({
            type = "server",
            host = "127.0.0.1",
            port = port,
          })
        end, 250)
      end
      dap.adapters.delve = dap.adapters.go
      dap.configurations.go = {
        {
          type = "go",
          name = "Debug current Go file",
          request = "launch",
          mode = "debug",
          program = "${file}",
          cwd = "${fileDirname}",
        },
      }

      -- Python uses debugpy. Install with: python3 -m pip install debugpy
      dap.adapters.python = {
        type = "executable",
        command = "python3",
        args = { "-m", "debugpy.adapter" },
      }
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Debug current Python file",
          program = "${file}",
          cwd = "${fileDirname}",
          console = "integratedTerminal",
          justMyCode = false,
          redirectOutput = true,
          env = { PYTHONUNBUFFERED = "1" },
        },
      }
    end,
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue/Start Debugging" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dr", function() require("dap").restart() end, desc = "Restart Debugging" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate Debugging" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval Expression" },
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Step Out" },
    },
  },
}
