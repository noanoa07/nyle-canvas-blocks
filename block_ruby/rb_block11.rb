include DX
# 初期設定用のコード (your setup code here)
Window.width   = 640
Window.height  = 480
Window.bgcolor = C_BLACK

img_bar = Image.load("bar.png")
bar_x = 0
bar_y = 480 - img_bar.height

img_ball = Image.load("ball.png")
ball_x = 300
ball_y = 400
dx     = 2                    # ◆追加


Window.loop do
  #bar_x += Input.x * 4       # 左右キーの場合
  bar_x = Input.mouse_x       # マウスの場合
  if bar_x < 20
    bar_x = 20
  elsif bar_x > 640 - 20 - img_bar.width
    bar_x = 640 - 20 - img_bar.width
  end

  ball_x += dx                # ◆追加

  Window.draw_box_fill(  0,   0,  20, 480, C_WHITE)
  Window.draw_box_fill(620,   0, 640, 480, C_WHITE)
  Window.draw_box_fill(  0,   0, 640,  20, C_WHITE)

  Window.draw(bar_x, bar_y, img_bar)
  Window.draw(ball_x, ball_y, img_ball)
end
