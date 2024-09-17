vim.wo.relativenumber = true
vim.wo.number = true
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
vim.opt.shell = "/bin/zsh"
vim.opt.foldmethod="indent"

vim.g.mapleader= " "
vim.keymap.set("n","<leader>d", vim.cmd('set autochdir'))

vim.keymap.set("n","<leader>sg", '<cmd>setlocal spell spelllang=de_at<CR>')

function ShowGermanThesaurus()
  local current_word = vim.fn.expand("<cword>")
  local handle = io.popen("german_thesaurus.sh " .. current_word)
  local result = handle:read("*a")
  handle:close()

  vim.api.nvim_command("new")  
  vim.api.nvim_buf_set_option(0, 'buftype', 'nofile')  
  vim.api.nvim_buf_set_option(0, 'bufhidden', 'wipe')  
  vim.api.nvim_buf_set_option(0, 'swapfile', false)  

  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(result, "\n"))
end

vim.api.nvim_set_keymap('n', '<leader>th', ':lua ShowGermanThesaurus()<CR>', { noremap = true, silent = true })

vim.keymap.set("n","<leader>bb", vim.cmd.bn)
vim.keymap.set("n","<leader>bd", vim.cmd.bd)
vim.keymap.set("n","<leader>ex", vim.cmd.Ex)
vim.keymap.set("n","<leader>tt", function()
	if term_open then
        	-- Close the terminal if it's open
        	for _, win in ipairs(vim.api.nvim_list_wins()) do
            		local buf = vim.api.nvim_win_get_buf(win)
            		if buf == term_buf then
                	vim.api.nvim_win_close(win, true)
                	term_open = false
                	return
            	end
	end
    	else
        	if term_buf == nil or not vim.api.nvim_buf_is_valid(term_buf) then
            		-- Create a new terminal buffer if it doesn't exist
            		vim.cmd('botright split | resize 10')
            		vim.cmd('term')
            		term_buf = vim.api.nvim_get_current_buf()
        	else
            		-- Reopen the existing terminal buffer
            		vim.cmd('botright split | resize 10')
            		vim.api.nvim_set_current_buf(term_buf)
        	end
        	vim.cmd('startinsert')
        	term_open = true
    	end
end
)
vim.keymap.set("t","<Esc>", '<C-\\><C-n>')

vim.keymap.set("n","<leader>fs", '<cmd> TexlabForward <CR>')
vim.keymap.set("n","<leader>pd", function()
	-- get the current buffer number
	local current_bufnr = vim.api.nvim_get_current_buf()

	-- get the file name associated with the buffer
	local file_name = vim.api.nvim_buf_get_name(current_bufnr)
	io.popen("nohup zathura ".. file_name:gsub("%.%w%w%w$", ".pdf") .. " &")
end
)

