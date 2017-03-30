
class Course

  @@all = []

  def self.reset_all
    @@all = []
  end

  def self.all
    @@all
  end

  attr_accessor :title,:schedule,:description

  def initialize
    @@all << self
  end


end
