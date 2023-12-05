local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "grounip.lsp.mason"
require("grounip.lsp.handlers").setup()
require "grounip.lsp.null-ls"
