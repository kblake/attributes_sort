require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class Person
  include AttributesSort

  attr_accessor :firstname,:lastname,:age

  def initialize(firstname="",lastname="",age=0)
    @firstname = firstname
    @lastname = lastname
    @age = age
  end
end


describe "AttributesSort" do
  before(:each) do
    @p1 = Person.new("joe","blow",89)
    @p2 = Person.new("joe","blow",12)
    @p3 = Person.new("mary","watson",32)
    @p4 = Person.new("annie","watson",9)
    @p5 = Person.new("bob","builder",12)
    @people = [@p1, @p2, @p3, @p4, @p5]
  end

  def test_sort(criteria, result)
    @people.attr_sort(:sort_by => criteria).should == result
  end

  it "sort_by standard ruby" do
    @people.sort_by{|person| [person.age,person.firstname]}.should == [@p4, @p5, @p2, @p3, @p1]
  end

  it "object must have attr accessible attributes for sort_by to work" do
    p = Person.new
    p.should respond_to(:firstname)
    p.should respond_to(:lastname)
    p.should respond_to(:age)
  end

  it "sort by last name" do
    test_sort([:lastname], [@p1, @p2, @p5, @p4, @p3])
  end

  it "sort by age" do
    test_sort([:age], [@p4, @p2, @p5, @p3, @p1])
  end

  it "sort by age then by first name" do
    test_sort([:age, :firstname], [@p4, @p5, @p2, @p3, @p1])
  end

  it "sort by age then by last name" do
    test_sort([:age, :lastname], [@p4, @p2, @p5, @p3, @p1])
  end

  it "sort by last name then by first name then by age" do
    test_sort([:lastname,:firstname,:age], [@p2, @p1, @p5, @p4, @p3])
  end

  it "raise error if criteria is not provided" do
    lambda {test_sort(nil, [@p1, @p2, @p5, @p4, @p3])}.should raise_error("You must pass in sort_by criteria")
  end

  it "raise error object does not respond to method call" do
    lambda {test_sort([:blah], [@p1, @p2, @p5, @p4, @p3])}.should raise_error("All objects must respond to sort criteria")
  end

  class Dog
    include AttributesSort

    attr_accessor :firstname,:lastname,:age

    def initialize(firstname="",lastname="",age=0)
      @firstname = firstname
      @lastname = lastname
      @age = age
    end
  end

  it "duck typed objects can be sorted as long as they all respond to same methods" do
    dog = Dog.new("fido", "zib", 7)
    @people << dog
    test_sort([:lastname,:firstname,:age], [@p2, @p1, @p5, @p4, @p3, dog])
  end

end

