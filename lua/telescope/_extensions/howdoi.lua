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
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local previewers = require('telescope.previewers')
local action_state = require('telescope.actions.state')
local entry_display = require('telescope.pickers.entry_display')

local opts = {}

-- Local storage for user-entered queries.
-- Used as the results table for the Telescope picker.
local queries = {}

local function setup(o)
	o = o or {}
	opts = vim.tbl_extend('force', { filetype = {} }, o)
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

	pickers.new(opts, {
		prompt_title = 'howdoi',
		finder = finder(queries),
		previewer = previewers.new_termopen_previewer({
			get_command = function(entry)
				return { 'howdoi', '-c', entry.value }
			end,
		}),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				table.insert(queries, 1, action_state.get_current_line())
				action_state.get_current_picker(prompt_bufnr):refresh(finder(queries), { reset_prompt = true })
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
