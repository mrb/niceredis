#! /usr/bin/env ruby

# Trying to make writing and reading from Redis a little bit nicer in
# Ruby.  No object model or anything fancy, just some nice classes for
# convenience.

# Hashes
# Strings
# Lists
# Sets
# Zsets

require 'rubygems'
require 'hiredis'

module NiceRedis
  def self.connect
    @redis ||= Redis.connect
  end
  
  class Base
    attr_accessor :key, :value, :members
    
    def initialize(attribs_hash=nil)
      @redis = NiceRedis.connect if !@redis
      if attribs_hash
        @key = attribs_hash.delete(:key) if attribs_hash.has_key?(:key)
        @value = attribs_hash.delete(:value) if attribs_hash.has_key?(:value)
        write_to_redis
      end
    end

    def write_to_redis
      puts "written"
    end
  end

  class RHash < Base
    def write_to_redis
      @redis.hset object_id, @key, @value
    end
  end

  class RSet < Base
    def add(value)
      @redis.sadd @key, value
    end

    def rem(value)
      @redis.srem @key, value
    end

    def pop
      @redis.spop @key
    end
        
    def is_member?(value)
      @redis.ismember @key, value
    end

    def members
      @redis.smembers @key
    end

    def write_to_redis
      @redis.sadd @key, @value
    end

    def random_member
      @redis.srandmember @key
    end

    # class methods
    def self.intesect_store
      
    end

    def self.union_store
      
    end

    def self.diff
      
    end
    
    def self.diff_store
      
    end

  end

  class RZSet < RSet

  end
end
