class LRUCache

  Error             = Class.new RuntimeError
  InvalidLimitError = Class.new Error
  NoLimitError      = Class.new Error

  Node = Struct.new(:key, :value, :mru, :lru)

  attr_reader :count, :limit

  # Sets up the new cache, optionally assigning given limit.
  def initialize(limit=nil)
    @index = {}
    @count = 0
    self.limit = limit if limit
  end

  # Empties the cache of all values.
  def clear
    count.times.each { delete_lru }
  end

  # Remove and return value from cache.
  def delete(key)
    node = @index.delete(key)
    return unless node
    @count -= 1
    node.mru.lru = node.lru if node.mru
    node.lru.mru = node.mru if node.lru
    @mru = node.lru if @mru == node
    @lru = node.mru if @lru == node
    node.value
  end

  # Return value from cache and sets it as most-recently-used.
  def get(key)
    node = @index[key]
    if node
      set_mru(node)
      node.value
    end
  end

  # Assigns a new limit to the cache.  Deletes least recently used
  # values if new limit is less than the count.
  def limit=(new_limit)
    new_limit and new_limit >= 1 or raise InvalidLimitError, "limit must be 1 or greater"
    extra_count = count - new_limit
    extra_count.times { delete_lru }
    @limit = new_limit
  end

  # Stores a value in the cache.
  def set(key, value)
    node = @index[key]
    unless node
      node = Node.new(key)
      @index[key] = node
      @count += 1
      delete_lru if count > ensure_limit
    end
    set_mru(node)
    node.value = value
  end

  alias [] get
  alias []= set

  private

  # Deletes the least recently used value from the cache.
  def delete_lru
    return unless @lru
    @count -= 1
    @index.delete(@lru.key)
    @lru = @lru.mru
    @lru.lru = nil if @lru
  end

  # Returns the limit if set, otherwise raises exception.
  def ensure_limit
    limit || raise(NoLimitError, "limit not set for LRUCache")
  end

  # Advances a node to the most recently used spot.
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