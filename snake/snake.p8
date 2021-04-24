pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
-- snake

snake_size = 4
snake_pos = {x=64, y=64}
snake_dir = {x=1, y=0}

tick_length = 4
current_tick = 0


function _update()
 read_input()
 move_snake()
end

function _draw()
 clear_screen()
 draw_snake()
end

function read_input()
 if snake_dir.x != 0 then
  if btn(2) then
   -- up
   snake_dir.x = 0
   snake_dir.y = -1
  elseif btn(3) then
   -- down
   snake_dir.x = 0
   snake_dir.y = 1
  end
 elseif snake_dir.y != 0 then
  if btn(0) then
   -- left
   snake_dir.x = -1
   snake_dir.y = 0
  elseif btn(1) then
   -- right
   snake_dir.x = 1
   snake_dir.y = 0
  end
 end
end

function clear_screen()
 rectfill(0,0,128,128,1)
end

function draw_snake()
 rectfill(
  snake_pos.x,
  snake_pos.y,
  snake_pos.x + snake_size,
  snake_pos.y + snake_size,
  12
 )
end

function move_snake()
 current_tick += 1
 if current_tick > tick_length then
  snake_pos.x += snake_size * snake_dir.x
  snake_pos.y += snake_size * snake_dir.y
  
  wrap_snake()
  current_tick = 0
 end
end

function wrap_snake()
 if snake_pos.x < 0 then
  snake_pos.x = 128 - snake_size
 end
 
 if snake_pos.x >= 128 then
  snake_pos.x = 0
 end
 
 if snake_pos.y < 0 then
  snake_pos.y = 128 - snake_size
 end
 
 if snake_pos.y >= 128 then
  snake_pos.y = 0
 end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
