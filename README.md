# howdoi.nvim
A [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) extension for previewing howdoi results in neovim.

![preview](https://user-images.githubusercontent.com/6345012/172077031-89b4b375-4e75-4743-943f-6dc369225074.gif)

## Dependencies
* [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
* [howdoi](https://github.com/gleitz/howdoi)

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

Currently, there are no options to configure.

## Usage
* Open the extension with `:Telescope howdoi`
* Type a query and press `Enter`, this will add it to the results list
* Hover over a result to see the response from `howdoi`

Entered queries are saved until you quit nvim.
