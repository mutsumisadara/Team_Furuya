class Drink
    def initialize(name,price)
      @name = name
      @price = price
    end
  
    #ハッシュ化用メソッド
    def to_h
      {name: @name, price: @price}
    end
  
    def self.coke
      Drink.new("Coke",120).to_h
    end
  
    def self.red_bull
      Drink.new("Red_bull",200).to_h
    end
  
    def self.water
      Drink.new("Water",100).to_h
    end
  
    def self.tea
      Drink.new("Tea",150).to_h
    end
  
    # 飲み物の種類を追加する場合は、以下のメソッドを作成する
    # def 飲み物名
    #   Drink.new("飲み物名",値段).to_h
    # end
  end