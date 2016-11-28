require 'ffi'
require "rbconfig"

module Fib
  extend FFI::Library
  ffi_lib "hoge.#{RbConfig::CONFIG['DLEXT']}"
  attach_function :fib, [:uint], :uint
end

puts Fib.fib(40)
