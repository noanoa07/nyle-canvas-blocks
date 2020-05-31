include DX
# 初期設定用のコード (your setup code here)
Window.width   = 640
Window.height  = 480
Window.bgcolor = C_BLACK

# 壁の厚み：左、右、上；20

# ブロックはItemクラスにする
class Item
  def initialize(x, y, image)
    @x = x
    @y = y
    @image  = image
    @width  = image.width
    @height = image.height
  end
  attr_accessor :x, :y, :image, :width, :height
end

# バーの準備
img_bar = Image.load("bar.png")
bar_x = 250
bar_y = 480 - img_bar.height
bar_width  = img_bar.width
bar_height = img_bar.height

# ボールの準備
img_ball = Image.load("ball.png")
img_ball.set_color_key(C_WHITE)
ball_x = 300
ball_y = 400
dx     =   2
dy     =  -2
ball_width  = img_ball.width
ball_height = img_ball.height

# ブロックの準備
img_block = Image.load("block.png")

# ブロック群の初期化
blocks = []
10.times do |x|
  5.times do |y|                                  # ◆追加
    blocks << Item.new(21 + (img_block.width + 2) * x, 21 + (img_block.height + 2) * y, img_block)  # ◆追加
  end                                             # ◆追加
end

# 1秒当たりの描画回数の設定（初期値：60）
#Window.fps = 30


# メインループ
Window.loop do
  # バーを動かす
  #bar_x += Input.x * 4       # 左右キーの場合
  bar_x = Input.mouse_x       # マウスの場合
  if bar_x < 20
    bar_x = 20
  elsif bar_x > 640 - 20 - img_bar.width
    bar_x = 640 - 20 - img_bar.width
  end

  # ボールを動かす
  ball_x += dx
  ball_y += dy

  # 壁に当たったら、跳ね返る（x方向）
  if ball_x < 20 || (ball_x + ball_width) > 620
    ball_x -= dx
    dx = -dx
  end
  
  # 壁に当たったら、跳ね返る(y方向)
  if ball_y < 20
    ball_y -= dy
    dy = -dy
  end
  
  # バーとの衝突判定
  if (ball_y + ball_height) >  (480 - bar_height)  &&
     (ball_y + ball_height) <= (480 - bar_height + dy.abs)  &&
     (ball_x + ball_width)  >  bar_x               &&
     ball_x                 <  (bar_x + bar_width)
    
    ball_y -= dy
    dy = -dy
  end


  # 画面描画
  Window.draw_box_fill(  0,   0,  20, 480, C_WHITE)
  Window.draw_box_fill(620,   0, 640, 480, C_WHITE)
  Window.draw_box_fill(  0,   0, 640,  20, C_WHITE)

  Window.draw(bar_x, bar_y, img_bar)
  Window.draw(ball_x, ball_y, img_ball)

  blocks.each do |block|
    Window.draw(block.x, block.y, block.image)
  end
end
