module Utils
  def self.generate_uid(length)
    length.times.map { [*'0'..'9', *'a'..'z', *'A'..'Z'].sample }.join
  end
end
