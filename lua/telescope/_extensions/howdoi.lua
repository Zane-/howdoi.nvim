-- Verify dependencies are installed
local has_telescope, telescope = pcall(require, 'telescope')

if not has_telescope then
  error('howdoi require telescope.nvim (https://github.com/nvim-telescope/telescope.nvim)')
end

local has_howdoi = vim.fn.executable('howdoi') == 1

if not has_howdoi then
  error('howdoi requires howdoi (https://github.com/gleitz/howdoi)')
end

local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local previewers = require('telescope.previewers')
local utils = require('telescope.utils')

local opts = {
  -- How many answers to return in the response.
  num_answers = 3,
  -- The binary to execute the howdoi command with.
  command_executor = { 'bash', '-c' },
  -- The command to pipe the results into for paging.
  pager_command = 'less -RS',
}

-- Local storage for user-entered queries.
-- Used as the results table for the Telescope picker.
local queries = {}

-- Gets the index of the given query in the queries table
-- Used to remove a query.
local function get_index_of_query(query)
  for i, q in pairs(queries) do
    if query == q then
      return i
    end
  end

  return nil
end

local function setup(o)
  o = o or {}
  opts = vim.tbl_deep_extend('force', opts, o)
end

local function run()
  local finder = function(table)
    return finders.new_table({
      results = table,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry,
        }
      end,
    })
  end

  local make_command = function(query)
    local howdoi_command = string.format('howdoi -c -n %s %s | %s', opts.num_answers, query, opts.pager_command)
    return vim.tbl_flatten({ opts.command_executor, howdoi_command })
  end

  local get_command_output = function(command)
    local lines = utils.get_os_command_output(command)

    -- Delete all ansi color codes.
    for i, line in pairs(lines) do
      lines[i] = line
        :gsub('\x1b%[%d+;%d+;%d+;%d+;%d+m', '')
        :gsub('\x1b%[%d+;%d+;%d+;%d+m', '')
        :gsub('\x1b%[%d+;%d+;%d+m', '')
        :gsub('\x1b%[%d+;%d+m', '')
        :gsub('\x1b%[%d+m', '')
    end

    return lines
  end

  pickers.new(opts, {
    prompt_title = 'howdoi',
    finder = finder(queries),
    previewer = previewers.new_termopen_previewer({
      get_command = function(entry)
        return make_command(entry.value)
      end,
    }),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local query = action_state.get_current_line()

        if query ~= '' then
          table.insert(queries, 1, query)
          action_state.get_current_picker(prompt_bufnr):refresh(finder(queries), { reset_prompt = true })
        end
      end)
      map('i', '<c-r>', function()
        table.remove(queries, get_index_of_query(action_state.get_selected_entry().value))
        action_state.get_current_picker(prompt_bufnr):refresh(finder(queries), { reset_prompt = true })
      end)
      map('i', '<c-p>', function()
        actions.close(prompt_bufnr)
        vim.api.nvim_put(get_command_output(make_command(action_state.get_selected_entry().value)), 'l', false, true)
      end)
      map('i', '<c-v>', function()
        actions.close(prompt_bufnr)
        vim.api.nvim_command('vsp ' .. action_state.get_selected_entry().value)
        vim.api.nvim_put(get_command_output(make_command(action_state.get_selected_entry().value)), 'l', false, true)
      end)
      map('i', '<c-x>', function()
        actions.close(prompt_bufnr)
        vim.api.nvim_command('sp ' .. action_state.get_selected_entry().value)
        vim.api.nvim_put(get_command_output(make_command(action_state.get_selected_entry().value)), 'l', false, true)
      end)
      map('i', '<c-y>', function()
        actions.close(prompt_bufnr)

        local reg = '"'
        if vim.opt.clipboard._value == 'unnamed' then
          reg = '+'
        end

        vim.fn.setreg(reg, get_command_output(make_command(action_state.get_selected_entry().value)))
      end)
      return true
    end,
  }):find()
end

return telescope.register_extension({
  setup = setup,
  exports = {
    howdoi = run,
  },
})
