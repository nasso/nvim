return {
  {
    -- detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",
  },
  {
    -- indent guides
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "▏" },
    },
  },
}
