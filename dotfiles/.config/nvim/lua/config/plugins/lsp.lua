-- LSP configuration (like VS Code IntelliSense)
return {
  -- Mason for managing LSP servers
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- Mason-lspconfig bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "pyright",
        "rust_analyzer",
        "gopls",
        "bashls",
        "jsonls",
        "yamlls",
        "html",
        "cssls",
        "tailwindcss",
        "eslint",
      },
      automatic_installation = true,
    },
  },

  -- LSP config
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      -- Setup keymaps when LSP attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- VS Code-like keymaps
          map("gd", require("telescope.builtin").lsp_definitions, "Go to Definition")
          map("gD", vim.lsp.buf.declaration, "Go to Declaration")
          map("gr", require("telescope.builtin").lsp_references, "Go to References")
          map("gI", require("telescope.builtin").lsp_implementations, "Go to Implementation")
          map("gy", require("telescope.builtin").lsp_type_definitions, "Go to Type Definition")

          -- Hover and signature (like VS Code hover)
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")

          -- Code actions (like VS Code quick fix)
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("<F2>", vim.lsp.buf.rename, "Rename (VS Code)")
          map("<leader>cr", vim.lsp.buf.rename, "Rename")

          -- Format
          map("<leader>cf", function()
            vim.lsp.buf.format({ async = true })
          end, "Format")

          -- Workspace
          map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
        end,
      })

      -- LSP capabilities with nvim-cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- Server configurations
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME },
              },
              completion = { callSnippet = "Replace" },
              diagnostics = { globals = { "vim" } },
            },
          },
        },
        ts_ls = {},
        pyright = {},
        rust_analyzer = {},
        gopls = {},
        bashls = {},
        jsonls = {},
        yamlls = {},
        html = {},
        cssls = {},
        tailwindcss = {},
        eslint = {},
      }

      -- Setup servers
      local lspconfig = require("lspconfig")
      for server, config in pairs(servers) do
        config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
        lspconfig[server].setup(config)
      end
    end,
  },
}
