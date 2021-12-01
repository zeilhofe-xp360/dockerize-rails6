# a test class for redis connection and read/write
class WelcomeController < ApplicationController
  def index
    redis = Redis.new(host: 'redis', port: 6379)
    redis.incr 'page_hits'

    @page_hits = redis.get 'page_hits'
  end
end
