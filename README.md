# howdoi.nvim

A [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) extension for previewing howdoi results in neovim.

![preview](https://user-images.githubusercontent.com/6345012/172497396-61e64081-a092-4981-a0da-d6997bd481f7.gif)

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
-- How many answers to return in the response.
num_answers = 3,
-- The binary to execute the howdoi command with.
command_executor = { 'bash', '-c' },
-- The command to pipe the results into for paging.
pager_command = 'less -RS',
```

To change these, use telescope's `setup` function:

```lua
require('telescope').setup({
  extensions = {
    howdoi = {
      num_answers = 5,
    },
  },
})
```

To apply a theme to howdoi, you can pass a merged table like so:

```lua
require('telescope').setup({
  extensions = {
    howdoi = vim.tbl_deep_extend(
      'force',
      { num_answers = 1 },
      require('telescope.themes').get_dropdown())
})
```

Note that the option `command_executor` needs to be a binary that can run a command on your system. If you don't have `bash` installed, you will need to change this. Likewise, if you don't have `less` installed, you will need to specify the option `pager_command`.

## Usage

- Open the extension with `:Telescope howdoi`
- Type a query and press `Enter`, this will add it to the results list
- Select a result to see the response from `howdoi`

Queries are saved until you quit nvim.

### Mappings

| Mapping    | Action                                         |
|------------|------------------------------------------------|
| `Ctrl + d` | Scroll the results down                        |
| `Ctrl + u` | Scroll the results up                          |
| `Ctrl + y` | Yank the results to the clipboard              |
| `Ctrl + p` | Pastes the results into the current buffer     |
| `Ctrl + v` | Pastes the results into a new vertical split   |
| `Ctrl + x` | Pastes the results into a new horizontal split |
| `Ctrl + r` | Removes the selected query from the list       |
