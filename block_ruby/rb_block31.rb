include DX
# 初期設定用のコード (your setup code here)
Window.width   = 640
Window.height  = 480
Window.bgcolor = C_BLACK

# 壁の厚み：左、右、上；20

# ボール、バー、ブロックはItemクラスにする
class Item
  def initialize(x, y, image)
    @x = x
    @y = y
    @image  = image
    @width  = image.width
    @height = image.height
  end
  attr_accessor :x, :y, :image, :width, :height

  # 衝突判定                           # ◇変更（Itemクラスのメソッドに）
  def collision?(item_b)              # ◇変更（書き直し）
    a_x0 = self.x                     # ◇変更（書き直し）
    a_x1 = self.x + self.width        # ◇変更（書き直し）
    a_y0 = self.y                     # ◇変更（書き直し）
    a_y1 = self.y + self.height       # ◇変更（書き直し）
                                      # ◇変更（書き直し）
    b_x0 = item_b.x                   # ◇変更（書き直し）
    b_x1 = item_b.x + item_b.width    # ◇変更（書き直し）
    b_y0 = item_b.y                   # ◇変更（書き直し）
    b_y1 = item_b.y + item_b.height   # ◇変更（書き直し）
                                      # ◇変更（Itemクラスのメソッドに）
    if a_x0 < b_x1 &&                 # ◇変更（Itemクラスのメソッドに）
       a_x1 > b_x0 &&                 # ◇変更（Itemクラスのメソッドに）
       a_y0 < b_y1 &&                 # ◇変更（Itemクラスのメソッドに） 
       a_y1 > b_y0                    # ◇変更（Itemクラスのメソッドに）
                                      # ◇変更（Itemクラスのメソッドに）
      true                            # ◇変更（Itemクラスのメソッドに）
    end                               # ◇変更（Itemクラスのメソッドに）
  end                                 # ◇変更（Itemクラスのメソッドに# ◇変更（書き直し）
end                                   # ◇変更（Itemクラスのメソッドに）


# バーの準備
img_bar = Image.load("bar.png")
bar = Item.new(250, 480 - img_bar.height, img_bar)

# ボールの準備
img_ball = Image.load("ball.png")
img_ball.set_color_key(C_WHITE)
ball = Item.new(300, 400, img_ball)
dx =  2   # ボールのスピード（x方向）
dy = -2   # ボールのスピード（y方向）

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
  #bar.x += Input.x * 4       # 左右キーの場合
  bar.x = Input.mouse_x       # マウスの場合
  if bar.x < 20
    bar.x = 20
  elsif bar.x > 640 - 20 - bar.width
    bar.x = 640 - 20 - bar.width
  end


  # ボールをy方向に動かす
  ball.y += dy

  # バーとの衝突判定
  if ball.collision?(bar)        # ◇変更（書き直し）
    if ball.y + ball.height  <=  480 - bar.height + dy.abs
      ball.y -= dy
      dy = -dy
    end
  end

  # 壁に当たったら、跳ね返る(y方向)
  if ball.y < 20
    ball.y -= dy
    dy = -dy
  end


  # ボールをx方向に動かす
  ball.x += dx

  # 壁に当たったら、跳ね返る（x方向）
  if ball.x < 20 || (ball.x + ball.width) > 620
    ball.x -= dx
    dx = -dx
  end
  

  # 画面描画
  Window.draw_box_fill(  0,   0,  20, 480, C_WHITE)
  Window.draw_box_fill(620,   0, 640, 480, C_WHITE)
  Window.draw_box_fill(  0,   0, 640,  20, C_WHITE)

  Window.draw(bar.x, bar.y, bar.image)
  Window.draw(ball.x, ball.y, ball.image)

  blocks.each do |block|
    Window.draw(block.x, block.y, block.image)
  end
end
