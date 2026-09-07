return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    cmd = "LeetDebug",
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

      local function ensure_file(path)
        if vim.fn.filereadable(path) == 0 then
          vim.fn.writefile({}, path)
        end
      end

      local codemap_output_path = vim.fn.expand("~/Projects/leet/output.txt")

      dapui.register_element("codemap_output", {
        render = function()
          ensure_file(codemap_output_path)
        end,
        buffer = function()
          ensure_file(codemap_output_path)
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
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      dap.adapters.go = function(callback)
        local dlv = executable_or("dlv", vim.fn.expand("~/go/bin/dlv"))
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
              return line ~= ""
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

      local function leetcode_cache_input()
        local body_path = vim.fn.stdpath("cache") .. "/leetcode/body"
        if vim.fn.filereadable(body_path) == 0 then
          return nil
        end

        local ok, body = pcall(vim.json.decode, table.concat(vim.fn.readfile(body_path), "\n"))
        if not ok or type(body) ~= "table" then
          return nil
        end

        return body.data_input
      end

      local function prompt_leetcode_input(param_count)
        local hint = param_count == 1 and "one JSON value per test case" or ("one JSON value per argument, " .. param_count .. " lines per test case")
        local input = vim.fn.input("LeetCode input (" .. hint .. ", use \\n between lines): ")
        input = vim.trim(input or "")
        if input == "" then
          return nil
        end
        return input:gsub("\\n", "\n")
      end

      local function python_leetcode_runner()
        local lines = vim.fn.readfile(vim.fn.expand("%:p"))
        local method_name
        local params = {}

        for _, line in ipairs(lines) do
          local name, args = line:match("^%s*def%s+([%w_]+)%s*%(([^)]*)%)")
          if name and name:sub(1, 2) ~= "__" then
            method_name = name
            for arg in args:gmatch("[^,]+") do
              arg = vim.trim(arg):gsub(":.*$", ""):gsub("=.*$", "")
              if arg ~= "" and arg ~= "self" then
                table.insert(params, arg)
              end
            end
            break
          end
        end

        if not method_name or #params == 0 then
          return nil
        end

        local input = leetcode_cache_input()
        if not input or input == "" then
          input = prompt_leetcode_input(#params)
        end
        if not input or input == "" then
          return nil
        end

        local raw_cases = vim.split(input, "\n", { plain = true, trimempty = true })
        local cases = {}
        for i = 1, #raw_cases, #params do
          local case = {}
          for j = 1, #params do
            if raw_cases[i + j - 1] then
              table.insert(case, raw_cases[i + j - 1])
            end
          end
          if #case == #params then
            table.insert(cases, case)
          end
        end

        if #cases == 0 then
          return nil
        end

        local runner = vim.deepcopy(lines)
        vim.list_extend(runner, {
          "",
          "",
          "if __name__ == '__main__':",
          "    import json",
          "    solution = Solution()",
          "    cases = [",
        })

        for _, case in ipairs(cases) do
          local encoded = {}
          for _, value in ipairs(case) do
            table.insert(encoded, string.format("json.loads(%q)", value))
          end
          table.insert(runner, "        (" .. table.concat(encoded, ", ") .. (#encoded == 1 and "," or "") .. "),")
        end

        vim.list_extend(runner, {
          "    ]",
          "    for args in cases:",
          string.format("        result = solution.%s(*args)", method_name),
          "        print({'args': args, 'result': result})",
        })

        local path = vim.fn.stdpath("cache") .. "/leetcode-debug-" .. vim.fn.fnamemodify(vim.fn.expand("%:t"), ":r") .. ".py"
        vim.fn.writefile(runner, path)
        return path
      end

      local function has_go_main(lines)
        for _, line in ipairs(lines) do
          if line:match("^%s*func%s+main%s*%(") then
            return true
          end
        end
        return false
      end

      local function parse_go_solution_signature(lines)
        for _, line in ipairs(lines) do
          local name, args, returns = line:match("^%s*func%s+([%w_]+)%s*%((.-)%)%s*(.-)%s*{?%s*$")
          if name and name ~= "main" then
            local params = {}
            for arg in args:gmatch("[^,]+") do
              local param_name, param_type = vim.trim(arg):match("^([%w_]+)%s+(.+)$")
              if param_name and param_type then
                table.insert(params, { name = param_name, type = vim.trim(param_type) })
              end
            end
            if #params > 0 then
              return name, params, vim.trim(returns or "")
            end
          end
        end
        return nil
      end

      local function strip_go_package(lines)
        local out = {}
        for i, line in ipairs(lines) do
          if not (i == 1 and line:match("^%s*package%s+")) then
            table.insert(out, line)
          end
        end
        return out
      end

      local function go_leetcode_runner()
        local source_path = vim.fn.expand("%:p")
        local lines
        if source_path ~= "" and vim.fn.filereadable(source_path) == 1 then
          lines = vim.fn.readfile(source_path)
        else
          lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        end

        if source_path ~= "" and has_go_main(lines) then
          return source_path
        end

        local method_name, params = parse_go_solution_signature(lines)
        if not method_name then
          return nil, "Could not find a Go solution function to debug"
        end

        local input = leetcode_cache_input()
        if not input or input == "" then
          input = prompt_leetcode_input(#params)
        end
        if not input or input == "" then
          return nil, "No LeetCode test input found"
        end

        local raw_cases = vim.split(input, "\n", { plain = true, trimempty = true })
        local cases = {}
        for i = 1, #raw_cases, #params do
          local case = {}
          for j = 1, #params do
            if raw_cases[i + j - 1] then
              table.insert(case, raw_cases[i + j - 1])
            end
          end
          if #case == #params then
            table.insert(cases, case)
          end
        end
        if #cases == 0 then
          return nil, "LeetCode input did not match the Go function parameters"
        end

        local runner = {
          "package main",
          "",
          "import (",
          '\tlcjson "encoding/json"',
          '\tlcfmt "fmt"',
          '\tlcruntime "runtime"',
          ")",
          "",
        }
        vim.list_extend(runner, strip_go_package(lines))
        vim.list_extend(runner, {
          "",
          "func main() {",
          "\tlcruntime.Breakpoint()",
        })

        for case_index, case in ipairs(cases) do
          for param_index, param in ipairs(params) do
            local var_name = string.format("case%dArg%d", case_index, param_index)
            table.insert(runner, string.format("\tvar %s %s", var_name, param.type))
            table.insert(runner, string.format("\tmustUnmarshal(%q, &%s)", case[param_index], var_name))
          end

          local args = {}
          for param_index, _ in ipairs(params) do
            table.insert(args, string.format("case%dArg%d", case_index, param_index))
          end
          table.insert(runner, string.format('\tlcfmt.Printf("case %d: %%#v\\n", %s(%s))', case_index, method_name, table.concat(args, ", ")))
        end

        vim.list_extend(runner, {
          "}",
          "",
          "func mustUnmarshal(raw string, dest any) {",
          "\tif err := lcjson.Unmarshal([]byte(raw), dest); err != nil {",
          "\t\tpanic(err)",
          "\t}",
          "}",
        })

        local dir = vim.fn.stdpath("cache") .. "/leetcode-debug-go"
        vim.fn.mkdir(dir, "p")
        local base = vim.fn.fnamemodify(source_path ~= "" and source_path or "leetcode", ":t:r")
        local path = dir .. "/" .. base .. "_debug.go"
        vim.fn.writefile(runner, path)
        return path
      end

      local function debug_current_file(name)
        if vim.bo.modified then
          vim.cmd.write()
        end

        local filetype = vim.bo.filetype
        local program = vim.fn.expand("%:p")
        local cwd = vim.fn.expand("%:p:h")

        if filetype == "python" then
          local runner = python_leetcode_runner()
          if runner then
            program = runner
            cwd = vim.fn.fnamemodify(runner, ":h")
            vim.notify("Debugging generated LeetCode Python runner", vim.log.levels.INFO, { title = "LeetDebug" })
          else
            vim.notify("No LeetCode test input found; debugging current Python file directly", vim.log.levels.WARN, { title = "LeetDebug" })
          end
        elseif filetype == "go" then
          local runner, err = go_leetcode_runner()
          if not runner then
            vim.notify(err or "Go LeetCode snippets need a package/main harness before DAP can debug them", vim.log.levels.WARN, { title = "LeetDebug" })
            return
          end
          program = runner
          cwd = vim.fn.fnamemodify(runner, ":h")
          if runner ~= vim.fn.expand("%:p") then
            vim.notify("Debugging generated LeetCode Go runner", vim.log.levels.INFO, { title = "LeetDebug" })
          end
        else
          vim.notify("LeetDebug is configured for Python and Go buffers", vim.log.levels.WARN, { title = "LeetDebug" })
          return
        end

        dap.run({
          type = filetype == "python" and "python" or "go",
          request = "launch",
          name = name,
          mode = filetype == "python" and nil or "debug",
          program = program,
          cwd = cwd,
          console = filetype == "python" and "integratedTerminal" or nil,
          justMyCode = filetype == "python" and false or nil,
          redirectOutput = filetype == "python" and true or nil,
        })
      end

      vim.api.nvim_create_user_command("LeetDebug", function()
        debug_current_file("Debug LeetCode solution")
      end, { desc = "Debug current LeetCode solution with nvim-dap" })

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
      { "<leader>ld", "<cmd>LeetDebug<CR>", desc = "LeetCode Debug" },
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Step Out" },
    },
  },
}
