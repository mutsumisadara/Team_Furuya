class Drink
  def initialize(name, price)
    @name = name
    @price = price
  end

  def to_h
    {name: @name, price: @price}
  end

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
    MONEY = [10, 50, 100, 500, 1000].freeze
    DRINKS = [Drink.cola, Drink.water, Drink.redbull, Drink.beer]
  
    # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
    def initialize
      # 最初の自動販売機に入っている金額は0円
      @slot_money = 0
      @sales_money = 0
      @stocks = {"コーラ": 5, "水": 0, "レッドブル": 0, "ビール": 1}
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

    def judge_1 #投入金額からの選ばれしもの
      drinks = DRINKS.find_all {|drink| @slot_money >= drink[:price] }
    end

    def judge_2 #在庫からの選ばれしもの
      judge_1.find_all { |drink| @stocks[drink[:name].to_sym] > 0 }
    end

    def choose_drink(number)
      choose_drink = judge_2
      puts "購入した飲み物：#{@selected_drink[:name]}"
    end

    # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
    def return_money
      # 返すお金の金額を表示する
      puts @slot_money
      # 自動販売機に入っているお金を0円に戻す
      @slot_money = 0
    end
  end