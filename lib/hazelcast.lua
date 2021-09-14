-- non blocking Lua driver for Hazelcast
local http = require "http";

function Hazelcast:new (o)
      o = o or {}   -- create object if user does not provide one
      setmetatable(o, self)
      self.__index = self
      return o
    end

function Hazelcast:config(host, port)
  self.host = host
  self.port = port
end

function Hazelcast:increment(key,value)
  local url = "http://" + self.host + ":" + self.port + "/hazelcast/rest/maps/ratelimiting/" + key
  value, err = http.reques("GET", url)
  response1, err = http.request("POST", url, {body = value.body + 1})
end

function Hazelcast:get(key)
  local url = "http://" + self.host + ":" + self.port + "/hazelcast/rest/maps/ratelimiting/" + key
  response, err = http.reques("GET", url)
  return response.body
end
