class LRUCache

  Node = Struct.new(:key, :value, :mru, :lru)

  attr_reader :count, :limit

  def initialize
    @index = {}
    @count = 0
    @limit = 1
  end

  def get(key)
    node = @index[key]
    if node
      set_mru(node)
      node.value
    end
  end

  alias [] get

  def limit=(new_limit)
    (count - new_limit).times { drop_lru }
    @limit = new_limit
  end

  def set(key, value)
    node = @index[key]
    unless node
      node = Node.new(key)
      @index[key] = node
      @count += 1
      drop_lru if count > limit
    end
    set_mru(node)
    node.value = value
  end

  alias []= set

  private

  def drop_lru
    return unless @lru
    @count -= 1
    @index.delete(@lru.key)
    @lru = @lru.mru
    @lru.lru = nil if @lru
  end

  def set_mru(node)
    return if node == @mru
    @mru.mru = node if @mru
    node.lru.mru = node.mru if node.lru
    node.lru = @mru
    @lru = node.mru if count > 1 and @lru == node
    @lru ||= node
    @mru = node
  end
end