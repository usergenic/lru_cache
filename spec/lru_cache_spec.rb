require "lru_cache"

describe LRUCache do

  let :cache do
    LRUCache.new
  end

  describe "#[]" do

    it "is an alias for get" do
      cache.method(:[]).should == cache.method(:get)
    end
  end

  describe "#[]=" do

    it "is an alias for set" do
      cache.method(:[]=).should == cache.method(:set)
    end
  end

  describe "#get" do

    it "returns an item for key when present in the cache" do
      cache.set("x", :x)
      cache.get("x").should == :x
    end

    it "returns nil when key is not in the cache" do
      cache.get("x").should be_nil
    end
  end

  describe "#set" do

    it "puts an item in the cache" do
      cache.get("x").should be_nil
      cache.set("x", :x)
      cache.get("x").should == :x
    end
  end

  describe "#count" do

    it "returns the number of items currently in cache" do
      cache.limit = 3
      cache.count.should == 0
      cache.set("x", :x)
      cache.count.should == 1
      cache.set("y", :y)
      cache.count.should == 2
      cache.set("x", :x2)
      cache.count.should == 2
    end
  end

  describe "#limit" do

    it "returns the maximum number of items in cache" do
      cache.limit = 500
      cache.limit.should == 500
    end

    it "defaults to 1" do
      cache.limit.should == 1
    end
  end

  describe "#limit=" do

    it "sets the maximum number of items in cache" do
      cache.limit = 500
      cache.limit.should == 500
    end

    it "drops items from cache if limit is newly less than count" do

      cache.limit = 3

      cache.set("x", :x)
      cache.set("y", :y)
      cache.set("z", :z)

      cache.count.should == 3

      cache.limit = 2
      cache.count.should == 2

      cache.get("x").should be_nil
      cache.get("y").should == :y
      cache.get("z").should == :z
    end
  end
end