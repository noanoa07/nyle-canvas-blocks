include DX
# 初期設定用のコード (your setup code here)
Window.width   = 640
Window.height  = 480
Window.bgcolor = C_BLACK

Window.loop do
  Window.draw_box_fill(  0,   0,  20, 480, C_WHITE)   # ◇変更（文字揃え）
  Window.draw_box_fill(620,   0, 640, 480, C_WHITE)   # ◆追加
end
