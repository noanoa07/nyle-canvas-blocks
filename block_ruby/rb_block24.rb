include DX
# 初期設定用のコード (your setup code here)
Window.width   = 640
Window.height  = 480
Window.bgcolor = C_BLACK

img_bar = Image.load("bar.png")
bar_x = 250
bar_y = 480 - img_bar.height
bar_width  = img_bar.width
bar_height = img_bar.height

img_ball = Image.load("ball.png")
ball_x = 300
ball_y = 400
dx     =   2
dy     =  -2
ball_width  = img_ball.width
ball_height = img_ball.height

img_block = Image.load("block.png")
block_widh = img_block.width
block_height = img_block.height

block00_x = 21
block00_y = 21

block01_x = 21 + block_widh + 2
block01_y = 21

block02_x = 21 + (block_widh + 2) * 2
block02_y = 21

block03_x = 21 + (block_widh + 2) * 3              # ◆追加
block03_y = 21                                     # ◆追加

block04_x = 21 + (block_widh + 2) * 4              # ◆追加
block04_y = 21                                     # ◆追加

block05_x = 21 + (block_widh + 2) * 5              # ◆追加
block05_y = 21                                     # ◆追加

block06_x = 21 + (block_widh + 2) * 6              # ◆追加
block06_y = 21                                     # ◆追加

block07_x = 21 + (block_widh + 2) * 7              # ◆追加
block07_y = 21                                     # ◆追加

block08_x = 21 + (block_widh + 2) * 8              # ◆追加
block08_y = 21                                     # ◆追加

block09_x = 21 + (block_widh + 2) * 9              # ◆追加
block09_y = 21                                     # ◆追加

# 1秒当たりの描画回数の設定（初期値：60）
#Window.fps = 30


Window.loop do
  #bar_x += Input.x * 4       # 左右キーの場合
  bar_x = Input.mouse_x       # マウスの場合
  if bar_x < 20
    bar_x = 20
  elsif bar_x > 640 - 20 - img_bar.width
    bar_x = 640 - 20 - img_bar.width
  end

  ball_x += dx
  ball_y += dy

  if ball_x < 20 || (ball_x + ball_width) > 620
    ball_x -= dx
    dx = -dx
  end
  
  if ball_y < 20
    ball_y -= dy
    dy = -dy
  end
  
  if (ball_y + ball_height) >  (480 - bar_height)  &&
     (ball_y + ball_height) <= (480 - bar_height + dy.abs)  &&
     (ball_x + ball_width)  >  bar_x               &&
     ball_x                 <  (bar_x + bar_width)
    
    ball_y -= dy
    dy = -dy
  end


  Window.draw_box_fill(  0,   0,  20, 480, C_WHITE)
  Window.draw_box_fill(620,   0, 640, 480, C_WHITE)
  Window.draw_box_fill(  0,   0, 640,  20, C_WHITE)

  Window.draw(bar_x, bar_y, img_bar)
  Window.draw(ball_x, ball_y, img_ball)

  Window.draw(block00_x, block00_y, img_block)
  Window.draw(block01_x, block01_y, img_block)
  Window.draw(block02_x, block02_y, img_block)
  Window.draw(block03_x, block03_y, img_block)          # ◆追加
  Window.draw(block04_x, block04_y, img_block)          # ◆追加
  Window.draw(block05_x, block05_y, img_block)          # ◆追加
  Window.draw(block06_x, block06_y, img_block)          # ◆追加
  Window.draw(block07_x, block07_y, img_block)          # ◆追加
  Window.draw(block08_x, block08_y, img_block)          # ◆追加
  Window.draw(block09_x, block09_y, img_block)          # ◆追加
end
