require "lru_cache"
require "thread"

class LRUCache::ThreadSafe < LRUCache

	def initialize(limit=nil)
    super
    @mutex = Mutex.new
  end

  def count
    @mutex.synchronize { super }
  end

  def clear
    @mutex.synchronize { super }
  end

  def delete(key)
    @mutex.synchronize { super }
  end

  def get(key)
    @mutex.synchronize { super }
  end

  def limit=(new_limit)
    @mutex.synchronize { super }
  end

  def set(key, value)
    @mutex.synchronize { super }
  end

  alias [] get
  alias []= set
end