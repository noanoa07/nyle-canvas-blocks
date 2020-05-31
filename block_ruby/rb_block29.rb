include DX
# 初期設定用のコード (your setup code here)
Window.width   = 640
Window.height  = 480
Window.bgcolor = C_BLACK

# 壁の厚み：左、右、上；20

# ボール、バー、ブロックはItemクラスにする         # ◇変更（ボール、バーもItemクラスに作り替え）
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
bar = Item.new(250, 480 - img_bar.height, img_bar)  # ◇変更（Itemクラスに作り替え）

# ボールの準備
img_ball = Image.load("ball.png")
img_ball.set_color_key(C_WHITE)
ball = Item.new(300, 400, img_ball)                 # ◇変更（Itemクラスに作り替え）
dx =  2   # ボールのスピード（x方向）                   # ◇変更（文字揃え、コメント追加）
dy = -2   # ボールのスピード（y方向）                   # ◇変更（文字揃え、コメント追加）

# ブロックの準備
img_block = Image.load("block.png")

# ブロック群の初期化
blocks = []
10.times do |x|
  5.times do |y|
    blocks << Item.new(21 + (img_block.width + 2) * x, 21 + (img_block.height + 2) * y, img_block)
  end
end

# 1秒当たりの描画回数の設定（初期値：60）
#Window.fps = 30


# メインループ
Window.loop do
  # バーを動かす
  #bar.x += Input.x * 4       # 左右キーの場合   # ◇変更（bar.x に）
  bar.x = Input.mouse_x       # マウスの場合     # ◇変更（bar.x に）
  if bar.x < 20                                # ◇変更（bar.x に）
    bar.x = 20                                 # ◇変更（bar.x に）
  elsif bar.x > 640 - 20 - bar.width           # ◇変更（bar.x、bar.width に）
    bar.x = 640 - 20 - bar.width               # ◇変更（bar.x、bar.width に）
  end

  # ボールを動かす
  ball.x += dx                                 # ◇変更（ball.x に）
  ball.y += dy                                 # ◇変更（ball.y に）

  # 壁に当たったら、跳ね返る（x方向）
  if ball.x < 20 || (ball.x + ball.width) > 620  # ◇変更（ball.x、ball.width に）
    ball.x -= dx                               # ◇変更（ball.x に）
    dx = -dx
  end
  
  # 壁に当たったら、跳ね返る(y方向)
  if ball.y < 20                               # ◇変更（ball.y に）
    ball.y -= dy                               # ◇変更（ball.y に）
    dy = -dy
  end
  
  # バーとの衝突判定
  if (ball.y + ball.height) >  (480 - bar.height)  &&                # ◇変更（ball.y、ball.height、bar.height に）
     (ball.y + ball.height) <= (480 - bar.height + dy.abs)  &&       # ◇変更（ball.y、ball.height、bar.height に）
     (ball.x + ball.width)  >  bar.x               &&                # ◇変更（ball.x、ball.width、bar.x に）
     ball.x                 <  (bar.x + bar.width)                   # ◇変更（ball.x、bar.x、bar.width に）
    
    ball.y -= dy                               # ◇変更（ball.y に）
    dy = -dy
  end


  # 画面描画
  Window.draw_box_fill(  0,   0,  20, 480, C_WHITE)
  Window.draw_box_fill(620,   0, 640, 480, C_WHITE)
  Window.draw_box_fill(  0,   0, 640,  20, C_WHITE)

  Window.draw(bar.x, bar.y, bar.image)        # ◇変更（bar.x、bar.y、bar.image に）
  Window.draw(ball.x, ball.y, ball.image)     # ◇変更（ball.x、ball.y、ball.image に）

  blocks.each do |block|
    Window.draw(block.x, block.y, block.image)
  end
end
