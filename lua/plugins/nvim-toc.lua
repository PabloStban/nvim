--return {
--"richardbizik/nvim-toc",
--toc_header = "Table of Contents",
--},

return {
  {
    "richardbizik/nvim-toc",
    config = function()
      require("nvim-toc").setup({
        toc_header = "Table of Contents",
      })

      --require("nvim-toc").generate_md_toc("list")
      --require("nvim-toc").generate_md_toc("numbered")
    end,
  },
}
