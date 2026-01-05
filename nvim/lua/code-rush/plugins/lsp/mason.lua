return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  -- Ensure mason loads before lspconfig
  priority = 1000,
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Setup mason-lspconfig
    -- Disable automatic enablement to prevent errors with Neovim 0.11+ API changes
    -- We'll manually set up servers via setup_handlers in lspconfig.lua
    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "ts_ls",  -- Updated from deprecated "tsserver"
        "html",
        "cssls",
        "tailwindcss",
        -- "svelte",
        "lua_ls",
        "graphql",
        "emmet_ls",
        -- "prismals",
        "pyright",
      },
      -- Disable automatic server enablement for Neovim 0.11+ compatibility
      -- This prevents the error: attempt to call field 'enable' (a nil value)
      automatic_enable = false,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        "pylint", -- python linter
        "eslint_d", -- js linter
      },
      -- Run installations in the background to avoid blocking Neovim startup
      run_on_start = true,
      -- Automatically update tools when new versions are available
      auto_update = false,
    })
    
    -- Helper function to check and install missing tools
    -- This can be called manually if automatic installation fails
    vim.api.nvim_create_user_command("MasonInstallTools", function()
      local tools = { "prettier", "stylua", "isort", "black", "pylint", "eslint_d" }
      local registry = require("mason-registry")
      
      for _, tool in ipairs(tools) do
        local pkg = registry.get_package(tool)
        if pkg and not pkg:is_installed() then
          pkg:install()
          vim.notify("Installing " .. tool .. "...", vim.log.levels.INFO)
        end
      end
    end, { desc = "Install all configured Mason tools" })
  end,
}
