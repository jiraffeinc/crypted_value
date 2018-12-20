require "crypted_value/version"
require 'bcrypt'

class CryptedValue
  DEFAULT_PEPPER = "default_pepper"
  DEFAULT_STRETCHES = 11
  class << self
    def pepper=(s)
      @pepper = s
    end

    def stretches=(n)
      @stretches = n
    end

    def pepper
      @pepper || DEFAULT_PEPPER
    end

    def stretches
      @stretches || DEFAULT_STRETCHES
    end
  end

  def initialize(value)
    if value.length == 60 && value[0..3] == "$2a$"
      @hashed_value = value
    else
      @orig_value = value
      @hashed_value = to_hash(value)
    end
  end

  def to_s
    @hashed_value
  end

  def ==(value)
    compare(value)
  end

  private
  def to_hash(value)
    ::BCrypt::Password.create("#{value}#{self.class.pepper}", cost: self.class.stretches).to_s
  end

  def compare(value)
    return false if @hashed_value.length < 1
    bcrypt   = ::BCrypt::Password.new(@hashed_value)
    value = "#{value}#{self.class.pepper}"
    value = ::BCrypt::Engine.hash_secret(value, bcrypt.salt)
    secure_compare(value, @hashed_value)
  end

  def secure_compare(a, b)
    return false if a.length < 1 || b.length < 1 || a.bytesize != b.bytesize
    l = a.unpack "C#{a.bytesize}"

    res = 0
    b.each_byte { |byte| res |= byte ^ l.shift }
    res == 0
  end
end
