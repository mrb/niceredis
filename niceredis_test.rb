require File.dirname(__FILE__) + '/test_helper'
require File.dirname(__FILE__) + '/niceredis'

include NiceRedis

context "Nice Redis" do
  setup do
    @redis = NiceRedis.connect
    @redis.flushall
  end

  context "Sets" do
    setup do
      @redis = NiceRedis.connect
      @redis.flushall
    end
    
    test "Makes a new set with attribs hash" do
      s = RSet.new(:key => "new_set", :value => 1)
      assert s.is_a?(RSet)
      assert @redis.smembers("new_set") == ["1"] 
    end

    test "Makes a new set without attribs hash" do
      s = RSet.new
      assert s.is_a?(RSet)
      s.key = "new_set"
      s.value = 1
      assert_equal @redis.smembers("new_set"), ["1"]
    end
  end
end
