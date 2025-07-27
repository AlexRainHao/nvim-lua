local M = {}

local cow = [[
     o
      o   ^__^
       o  (oo)\_______
          (__)\       )\/\
               ||----w |
               ||     ||
      ]]

local char_top_bottom = '─'
local char_sides = '│'
local char_top_left = '╭'
local char_top_right = '╮'
local char_bottom_right = '╯'
local char_bottom_left = '╰'

local function concat_fortune(fortune)
  local clean_fortune = {}
  for _, line in ipairs(fortune) do
    if line:match('%s') then
      table.insert(clean_fortune, line)
    end
  end

  local result = { '', '', clean_fortune[#clean_fortune] }
  for i = 1, #clean_fortune - 1 do
    result[1] = result[1] .. clean_fortune[i]
  end

  return result
end

-- Function to wrap a string to fit the specified width
local function wrap_text(input, linewidth)
  local lines = {}
  local line_len = 0
  local line = ''
  for word in input:gmatch('[^%s]+') do
    if line_len + #word > linewidth then
      table.insert(lines, line)
      line_len = 0
      line = ''
    end
    if line == '' then
      line = word
    else
      line = line .. ' ' .. word
    end
    line_len = line_len + #word + 1
  end
  table.insert(lines, line)
  return lines
end

-- The draw_rectangle function
local function draw_rectangle(h_padding, v_padding, fortune)
  -- Max width is 100
  local max_width = 50 - 2 * h_padding

  local c_fortune = concat_fortune(fortune)

  -- Wrap the first part of the quote
  local wrapped_quote = wrap_text(c_fortune[1], max_width - 2)
  local wrapped_author = wrap_text(c_fortune[3], max_width - 2)

  -- Calculate the necessary width and height
  local width = max_width

  -- Top border
  local rectangle = char_top_left .. string.rep(char_top_bottom, width + 2 * h_padding) .. char_top_right .. '\n'

  -- Add top padding
  for _ = 1, v_padding do
    rectangle = rectangle .. char_sides .. string.rep(' ', width + 2 * h_padding) .. char_sides .. '\n'
  end

  -- Add the wrapped quote
  for _, line in ipairs(wrapped_quote) do
    rectangle = rectangle
        .. char_sides
        .. string.rep(' ', h_padding)
        .. line
        .. string.rep(' ', width - #line + h_padding)
        .. char_sides
        .. '\n'
  end

  -- Add the blank line
  rectangle = rectangle .. char_sides .. string.rep(' ', width + 2 * h_padding) .. char_sides .. '\n'

  -- Add the wrapped author
  for _, line in ipairs(wrapped_author) do
    rectangle = rectangle
        .. char_sides
        .. string.rep(' ', h_padding)
        .. line
        .. string.rep(' ', width - #line + h_padding)
        .. char_sides
        .. '\n'
  end

  -- Add bottom padding
  for _ = 1, v_padding do
    rectangle = rectangle .. char_sides .. string.rep(' ', width + 2 * h_padding) .. char_sides .. '\n'
  end

  -- Bottom border
  rectangle = rectangle
      .. char_bottom_left
      .. string.rep(char_top_bottom, width + 2 * h_padding)
      .. char_bottom_right
      .. '\n'

  return rectangle
end

-- TODO: wrap into public libs
-- TODO: author right padding
function M.cowsays(fortune)
  local r = table.concat(
    { draw_rectangle(2, 1, fortune),
      cow }, '\n')
  local t = {}
  for line in r:gmatch('[^\n]+') do
    table.insert(t, line)
  end
  return t
end

return M
