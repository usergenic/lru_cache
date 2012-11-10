# LRUCache

It's a simple in-memory cache that expires the least recently used item
in the cache when the count of items in the cache reaches a fixed limit. 

## Usage

    require "lru_cache"

    # create a new cache with a 1,000 item limit
    cache = LRUCache.new(1_000)

    # get or set item in cache
    cache["some key"] ||= expensive_operation

By default the LRUCache is not thread-safe.  If you intend to access the
cache in multi-threaded code, use LRUCache::ThreadSafe.

    require "lru_cache/thread_safe"

    # create a new thread-safe cache with a 1,000 item limit
    cache = LRUCache::ThreadSafe.new(1_000)

    # get or set item in cache
    cache["some key"] ||= expensive_operation

## Public Instance Methods

 * `#clear` empties the cache
 * `#count` returns the number of items currently in cache
 * `#delete(key)` removes an item from the cache
 * `#get(key)` returns the cached value or nil
 * `#limit` returns the cache limit (defaults to 1)
 * `#limit=value` sets the cache limit to value
 * `#set(key, value)` stores the value in the cache
 * `#[key]` alias for `#get(key)`
 * `#[key]=value` alias for `#set(key, value)`

## License

This code is released under the MIT license, and is copyright 2012 by Brendan Baldwin. Please see the accompanying LICENSE file for the full text of the license.