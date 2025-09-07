-- lua/plugins/lsp.lua
return {
  -- 1) LSP core
  { "neovim/nvim-lspconfig" },

  -- 2) Installer for LSP servers
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  -- 3) Mason ↔ lspconfig bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
    config = function()
      local lspconfig = require("lspconfig")

      -- Capabilities (auto-upgrade if you use nvim-cmp; safe if you don't)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      -- Common on_attach: useful LSP keymaps when a server attaches
      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        map("n", "gr", vim.lsp.buf.references, "List references")
        map("n", "K", vim.lsp.buf.hover, "Hover docs")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev diagnostic")
        map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
        map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
      end

      -- Ensure these servers are installed
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "jsonls", "lua_ls" },
        automatic_installation = true,
      })

      -- Python
      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- JSON
      lspconfig.jsonls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          json = {
            validate = { enable = true },
          },
        },
      })

      -- Lua (configured via .luarc.json)
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  },
}
