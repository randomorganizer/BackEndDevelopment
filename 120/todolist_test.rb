require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!


require_relative 'todo_list'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  # Your tests go here. Remember they must start with "test_"
  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    todo = @list.shift
    assert_equal(todo, @todo1)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    todo = @list.pop
    assert_equal(todo, @todo3)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(false, @list.done?)
  end

  def test_add_raise_error
    assert_raises(TypeError) do
      @list.add("Todo")
    end
  end

  def test_add_alias
    my_todo = Todo.new('Eat Breakfast')
    @list << my_todo
    todos = (@todos << my_todo)

    assert_equal(@list.to_a, todos)
  end

  def test_item_at
    assert_equal(@todo1, @list.item_at(0))
    assert_raises(IndexError) do
      @list.item_at(10)
    end
  end

  def test_mark_done_at
    @list.mark_done_at(0)
    assert_equal(true, @list.first.done?)
    assert_raises(IndexError) do
      @list.item_at(10)
    end
  end

  def test_mark_undone_at
    @list.mark_undone_at(0)
    assert_equal(false, @list.first.done?)
  end

  def test_done!
    @list.done!
    assert_equal(true, @list.done?)
  end

  def test_undone!
    @list.done!
    @list.undone!
    assert_equal(false, @list.done?)
  end

  def test_remove_at
    assert_raises(IndexError) do
      @list.remove_at(10)
    end
    @list.remove_at(0)
    assert_equal(2, @list.size)
  end

  def test_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_done_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT
    @list.mark_done_at(1)
    assert_equal(output, @list.to_s)
  end

  def test_all_done_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    @list.done!
    
    assert_equal(output, @list.to_s)
  end

  def test_each
    todotest = nil
    @list.each do |todo|
      refute_equal(todo, todotest)
      todotest = todo
    end
  end

  def test_each_return
    testlist = @list.each { }
    assert_equal(@list, testlist)
  end

  def test_select
    assert_equal(1, @list.select {|todo| todo.title == 'Buy milk'}.size)
  end

  def test_find_by_title
    todo = @list.find_by_title("Buy milk")
    assert_equal("Buy milk", todo.title)
  end

  def test_all_done
    list = @list.all_done
    assert_equal(nil, list)
  end

  def test_all_not_done
    list = @list.all_not_done
    assert_equal(3, list.size)
  end

  def test_mark_done_by_title
    @list.mark_done("Buy milk")
    assert_equal(true, @list.find_by_title("Buy milk").done?)
  end
end

