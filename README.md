# howdoi.nvim

A [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) extension for previewing howdoi results in neovim.

![preview](https://user-images.githubusercontent.com/6345012/172084208-4548f1b3-f989-43b7-81df-d0ddc1ef7b40.gif)

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
-- How many answers to return in the response
num_answers = 3
-- Whether or not to give the source of the answer(s)
explain_answer = false
```

To change these, use telescope's `setup` function:

```lua
require('telescope').setup({
  extensions = {
    howdoi = {
      num_answers = 5,
      explain_answer = true,
    },
  },
})
```

## Usage

- Open the extension with `:Telescope howdoi`
- Type a query and press `Enter`, this will add it to the results list
- Select a result to see the response from `howdoi`

Queries are saved until you quit nvim.

### Mappings

| Mapping | Action                                         |
|---------|------------------------------------------------|
| `<C-x>` | Pastes the results into a new horizontal split |
| `<C-v>` | Pastes the results into a new vertical split   |
| `<C-p>` | Pastes the results into the current buffer     |
