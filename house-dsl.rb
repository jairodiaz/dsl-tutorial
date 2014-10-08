module CustomHouse

  def self.build(name, &block)
    house = House.new(name)
    house.instance_eval(&block)
    return house
  end

  class House
    attr_accessor :name, :floors

    def initialize(name = '')
      @name = name.to_s
      @floors = []
    end

    def floor(number, &block)
      fl = Floor.new(number)
      fl.instance_eval(&block)
      @floors << fl
    end

    def to_s
      str = "House named #{@name} has #{@floors.length} floors.\n"
      @floors.each do |f|
        str << f.to_s
      end
      str
    end
  end

  class Floor
    attr_accessor :number, :rooms

    def initialize(number = 0)
      @number = number
      @rooms = []
    end

    def room(type)
      @rooms << Room.new(type)
    end

    def to_s
      str = "Floor #{@number} has #{@rooms.length} rooms ("
      @rooms.each do |r|
        str += "#{r.type}, "
      end
      str.chop!.chop!
      str += ")\n"
      str
    end
  end

  class Room
    attr_reader :type

    def initialize(type)
      @type = type
    end
  end
end

h = CustomHouse.build :home do
  floor(1) {
    room :den
    room :kitchen
  }

  floor(2) {
    room :bedroom
    room :bathroom
  }
end

puts h
