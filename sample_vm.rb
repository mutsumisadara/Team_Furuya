require_relative 'sample_drink'

class VendingMachine
  #使用できるお金
  MONEY = [10, 50, 100, 500, 1000].freeze
  #取り扱いのある飲み物
  DRINKS = [Drink.coke, Drink.red_bull, Drink.water, Drink.tea]
  
  #初期値
  def initialize
    @total_money = 0
    @total_sales = 0
    @stocks = {Coke: 5, Red_bull: 0, Water: 3, Tea: 1}
    @selected_drink = []
  end

  #投入金額の確認
  def current_total_money
    @total_money
  end

  #売上金額の確認
  def current_total_sales
    @total_sales
  end
  
  # 払い戻し
  def return_money
    puts "#{@total_money}円の返金"
    @total_money = 0
  end
    
  # お金を投入
  def insert(money)
    return false unless MONEY.include?(money)
    @total_money += money
  end

  #金額・在庫より購入できる飲み物を判断
  def judge
    #投入金額より価格が低い飲み物を抽出
    drinks = DRINKS.select {|drink| @total_money >= drink[:price] }
    #上で抽出した飲み物からさらに在庫数が1本以上の飲み物を抽出
    drinks.select { |drink| @stocks[drink[:name].to_sym] > 0 }
  end

  #購入できる飲み物を一覧で表示
  def available_drinks_list
    available_drinks = judge
    available_drinks.each.with_index(1) do |available_drink, i|
      puts "番号：#{i} #{available_drink[:price]}円 #{available_drink[:name]}"
      puts "--------------------------"
    end
    puts "番号：#{available_drinks.size + 1} ランダム"
    puts "--------------------------"
  end

  # 飲み物を選択・購入
  def select_drink(drink_number)
    available_drinks = judge
    #選択購入かランダム購入かで条件分岐
    drink_number == available_drinks.size + 1 ? @selected_drink = available_drinks.sample : @selected_drink = available_drinks[drink_number - 1]
    calculate
    puts "購入した飲み物：#{@selected_drink[:name]}"
  end

  # 各変数を計算
  def calculate
    #在庫数を計算
    @stocks[@selected_drink[:name].to_sym] -= 1
    #合計金額を計算
    @total_money -= @selected_drink[:price]
    #売上金額を計算
    @total_sales += @selected_drink[:price] 
  end

  #飲み物を補充
  def store_drink(drink_name, stock)
    @stocks[drink_name] += stock
  end

  #飲み物の在庫を確認
  def stock_info
    puts "在庫状況"
    puts "---------------------------------"
    @stocks.each do |name, stock|
      puts "#{name}: #{stock}本"
    end
    puts "---------------------------------"
  end
end