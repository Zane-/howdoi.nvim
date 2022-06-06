# howdoi.nvim

A [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) extension for previewing howdoi results in neovim.

![preview](https://user-images.githubusercontent.com/6345012/172078691-6f4ba50c-31d2-45c5-b7ea-b764054cd417.gif)

## Dependencies

- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [howdoi](https://github.com/gleitz/howdoi)

## Setup

Install using your favorite package manager:

[packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use 'zane-/howdoi.nvim'
```

Load the extension in telescope:

```lua
require('telescope').load_extension('howdoi')
```

Default config:

```lua
-- How many results to return in the response
num_results = 1
-- Whether or not to give the source of the answer
explain_answer = false
```

To change these, use telescope's `setup` function:

```lua
require('telescope').setup({
	extensions = {
		howdoi = {
			num_results = 5,
			explain_answer = true,
		}
	},
})
```

## Usage

- Open the extension with `:Telescope howdoi`
- Type a query and press `Enter`, this will add it to the results list
- Hover over a result to see the response from `howdoi`

Queries are saved until you quit nvim.
