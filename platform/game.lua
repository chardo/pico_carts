-- let's make a platformer

char_pos = {
  x = 10,
  y = 120
}
prev_char_pos = {
  x = 10,
  y = 120
}
char_velocity = {
  x = 0,
  y = 0
}

char_size = 4
max_char_speed = 2.5
acceleration = 0.8
deceleration = 0.8
x_velocity = 0

jump_start_time = 0
min_jump_launch_time = 0.05
max_jump_launch_time = 0.15
midair = false

function _init()

end

function _update()
  take_input()
  move_character()
end

function _draw()
  cls(1)
  draw_character()
end

function draw_character()
  rectfill(
    char_pos.x,
    char_pos.y,
    char_pos.x + char_size,
    char_pos.y + char_size,
    7
  )
end

function take_input()
  move_input()
  jump_input()
end

function move_character()
  char_pos.x += char_velocity.x

  char_pos.y = min(120, char_pos.y + char_velocity.y)
  if (char_pos.y == 120) then
    midair = false
  end
end

function move_input()
  if btn(0) then 
    -- left
    if (char_velocity.x <= (-1 * max_char_speed)) then
      char_velocity.x = -1 * max_char_speed
    else
      char_velocity.x -= acceleration
    end
  elseif btn(1) then
    -- right
    if (char_velocity.x >= max_char_speed) then
      char_velocity.x = max_char_speed
    else
      char_velocity.x += acceleration
    end
  else
    -- no input, slow down
    if (char_velocity.x > (-1 * deceleration) and char_velocity.x < deceleration) then
      char_velocity.x = 0
    else
      if (char_velocity.x < 0) then
        char_velocity.x += deceleration
      else
        char_velocity.x -= deceleration
      end
    end
  end
end

function jump_input()
  if not midair then
    if btn(2) then
      midair = true
      jump_start_time = time()
    end
  end

  if midair then
    local jumping_time = time() - jump_start_time
    if (btn(2) and (jumping_time <= max_jump_launch_time)) or
       (jumping_time < min_jump_launch_time) then 
      char_velocity.y = -4
    else
      char_velocity.y += 0.8
    end
  end
end