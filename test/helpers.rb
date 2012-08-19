$:.unshift File.dirname(__FILE__) + '/lib'

require 'lib/faye.rb'

include Faye

def E(*args)
  Element.new(*args)
end

