{
  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    packages."x86_64-linux" = let
      nvimconf = inputs.nvf.lib.neovimConfiguration {
        inherit (nixpkgs.legacyPackages."x86_64-linux") pkgs;
        modules = [
          {
            config.vim = {
              luaConfigPre = ''
                vim.lsp.inlay_hint.enable(true)
                vim.diagnostic.config({virtual_lines=true, virtual_text=true})
              '';
              undoFile.enable = true;
              keymaps = [
                {
                  mode = "n";
                  key = "<C-Bslash>";
                  action = ":split<CR>";
                }
                {
                  mode = "n";
                  key = "<C-/>";
                  action = ":vsplit<CR>";
                }
                {
                  mode = "n";
                  key = "<BS>";
                  action = ":noh<CR>";
                  silent = true;
                }
                {
                  mode = "n";
                  key = "<C-H>";
                  action = "<C-W><C-H>";
                }
                {
                  mode = "n";
                  key = "<C-J>";
                  action = "<C-W><C-J>";
                }
                {
                  mode = "n";
                  key = "<C-K>";
                  action = "<C-W><C-K>";
                }
                {
                  mode = "n";
                  key = "<C-L>";
                  action = "<C-W><C-L>";
                }
              ];
              options = {
                mouse = "n";
                tabstop = 2;
                shiftwidth = 0;
                autoindent = false;
              };

              useSystemClipboard = true;
              theme.enable = false;
              theme.name = "onedark";
              lazy.enable = true;
              extraPlugins = {
                "onedark.nvim" = {
                  package = nixpkgs.legacyPackages."x86_64-linux".vimPlugins.onedark-nvim;
                  setup = ''
                    require('onedark').setup {
                      style = 'dark'
                    }
                    require('onedark').load()
                  '';
                };
              };
              autocomplete.nvim-cmp.enable = true;
              autopairs.nvim-autopairs.enable = true;
              comments.comment-nvim.enable = true;
              debugger.nvim-dap = {enable = true;};
              visuals = {
                fidget-nvim = {
                  enable = true;
                  setupOpts = {notification.override_vim_notify = true;};
                };
                nvim-web-devicons.enable = true;
              };
              notes.todo-comments.enable = true;
              git.gitsigns.enable = true;
              utility = {
                surround.enable = true;
                oil-nvim.enable = true;
              };
              treesitter = {
                enable = true;
                autotagHtml = true;
              };
              lsp = {
                enable = true;
                formatOnSave = true;
                lspSignature.enable = true;
                lspconfig.enable = true;
                lsplines.enable = true;
                null-ls.enable = true;
                mappings = {
                  codeAction = "<leader>vca";
                  goToDefinition = "gd";
                  goToDeclaration = "gD";
                  hover = "K";
                  listReferences = "gr";
                  renameSymbol = "<leader>vrn";
                  signatureHelp = "<leader>vsh";
                };
              };
              snippets.luasnip.enable = true;
              telescope = {
                enable = true;
                mappings = {
                  buffers = "<Tab>";
                  findFiles = "<S-Tab>";
                };
              };
              statusline.lualine = {
                enable = true;
                theme = "onedark";
                componentSeparator = {
                  left = "";
                  right = "";
                };
                sectionSeparator = {
                  left = "";
                  right = "";
                };
              };
              languages = {
                enableDAP = true;
                enableExtraDiagnostics = true;
                enableFormat = true;
                enableLSP = true;
                enableTreesitter = true;

                rust = {
                  enable = true;
                  crates.enable = true;
                };

                lua.enable = true;
                python.enable = true;

                ts.enable = true;
                markdown.enable = true;

                nix.enable = true;

                clang.enable = true;
                haskell.enable = true;

                bash.enable = true;
              };
            };
          }
        ];
      };
    in {default = nvimconf.neovim;};
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
  };
}
