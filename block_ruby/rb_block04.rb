include DX
# 初期設定用のコード (your setup code here)
Window.width   = 640
Window.height  = 480
Window.bgcolor = C_BLACK

img_bar = Image.load("bar.png")                     # ◆追加
bar_x = 0                                           # ◆追加
bar_y = 480 - img_bar.height                        # ◆追加

Window.loop do
  Window.draw_box_fill(  0,   0,  20, 480, C_WHITE)
  Window.draw_box_fill(620,   0, 640, 480, C_WHITE)
  Window.draw_box_fill(  0,   0, 640,  20, C_WHITE)

  Window.draw(bar_x, bar_y, img_bar)                # ◆追加
end
