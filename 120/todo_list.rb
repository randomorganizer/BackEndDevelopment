# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.
require 'pry'
class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  # rest of class needs implementation
  def <<(todo)
    raise TypeError, 'Can only add Todo objects' unless todo.is_a? Todo
    @todos.push(todo)
  end
  alias_method :add, :<<

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def item_at(index)
    @todos.fetch(index)
  end

  def done?
    @todos.all? { |todo| todo.done? }
  end

  def done!
    @todos.each { |todo| todo.done! }
  end

  def undone!
    @todos.each { |todo| todo.undone! }
  end

  def mark_done_at(index)
    @todos.fetch(index).done!
  end

  def mark_undone_at(index)
    @todos.fetch(index).undone!
  end

  def pop
    @todos.pop
  end

  def shift
    @todos.shift
  end

  def remove_at(index)
    @todos.fetch(index)
    @todos.delete_at(index)
  end

  def to_s
    description = "---- Today's Todos ----"
    @todos.each do |todo|
      description += "\n" + todo.to_s
    end
    description
  end

  def to_a
    @todos
  end

  def each
    @todos.each { |todo| yield(todo) }
    self
  end

  def select
    selected = TodoList.new('Unknown')
    each do |todo|
      selected.add(todo) if yield(todo)
    end
    selected
  end

  def find_by_title(title)
    selection = select do |todo|
      todo.title == title
    end
    selection.size == 0 ? nil : selection.first
  end

  def all_done
    selection = select do |todo|
      todo.done?
    end
    selection.size == 0 ? nil : selection
  end

  def all_not_done
    selection = select do |todo|
      !todo.done?
    end
    selection.size == 0 ? nil : selection
  end

  def mark_done(title)
    selection = select do |todo|
      todo.title == title
    end
    selection.mark_done_at(0)
  end
end
