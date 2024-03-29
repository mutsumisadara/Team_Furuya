class Drink # SDARAドリンクマシーン
  # インスタンスを初期化　引数(name, price)
  def initialize(name, price)
    # インスタンス作成時に渡された名前をインスタンス変数に代入
    @name = name
    @price = price
  end

  #ハッシュ化用メソッド
  def to_h
    {name: @name, price: @price}
  end

  #コーラと120をハッシュ化メソッドでハッシュ化して、.newでインスタンス化する
  #インスタンス化したものを、selfでDrinkcolaをクラスメソッドとして定義
  #コーラ、１２０として扱えるようにする
  def self.cola
    Drink.new("コーラ", 120).to_h
  end

  def self.water
    Drink.new("水", 100).to_h
  end

  def self.redbull
    Drink.new("レッドブル", 200).to_h
  end

  def self.beer
    Drink.new("ビール", 350).to_h
  end
end

class VendingMachine
    # ステップ０　お金の投入と払い戻しの例コード
    # ステップ１　扱えないお金の例コード

    # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
    # 定数として定義
    MONEY = [10, 50, 100, 500, 1000].freeze
    DRINKS = [Drink.cola, Drink.water, Drink.redbull, Drink.beer]

    # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
    def initialize
      # 最初の自動販売機に入っている金額は0円
      # 投入金額
      @slot_money = 0
      # 売上金額
      @sales_money = 0
      # 在庫
      @stocks = {"コーラ": 5, "水": 4, "レッドブル": 3, "ビール": 2}
      # 選んだドリンク
      @selected_drink = []
    end

    # 投入金額の総計を取得できる。
    def current_slot_money
      # 自動販売機に入っているお金を表示する
      @slot_money
    end

    # 全部の売り上げ金額
    def current_sales_money
      @sales_money
    end

    # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
    # 投入は複数回できる。
    def slot_money(money)
      # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
      # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
      return false unless MONEY.include?(money)
      # 自動販売機にお金を入れる
      @slot_money += money
    end

    # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
    def return_money
      # 返すお金の金額を表示する
      puts @slot_money
      # 自動販売機に入っているお金を0円に戻す
      @slot_money = 0
    end

    def judge_1 #投入金額からの選ばれしもの
      drinks = DRINKS.find_all {|drink| @slot_money >= drink[:price] }
    end

    def judge_2 #在庫からの選ばれしもの
      # to_symで文字列をシンボル（数字）として扱う
      judge_1.find_all { |drink| @stocks[drink[:name].to_sym] > 0 }
    end

    # 買えるドリンクリスト
  def buy_drinks_list
        buy_drinks = judge_2
        buy_drinks.each.with_index(1) do |buy_drink, i|
          puts "番号：#{i} #{buy_drink[:price]}円 #{buy_drink[:name]}"
          puts "--------------------------"
        end
  end


    # 飲み物を選択・購入しようとするところ
    def select_drink(drink_number)
      buy_drinks = judge_2
      #選択購入
      @selected_drink = buy_drinks[drink_number - 1]
      # total_keisan
      @stocks[@selected_drink[:name].to_sym] -= 1
      puts "購入した飲み物：#{@selected_drink[:name]}"
    end

    # def total_keisan
      
    #   @now_drinks = @stocks[@selected_drink[:name].to_sym] -= 1
    #   # [@stocks[drink[:name].to_sym] -= @selected_drink[drink[:name].to_sym]]
    #   # puts @now_drinks
    # end
  end