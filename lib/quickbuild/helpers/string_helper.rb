class String
  ASTERISK = '*'

  def self.asterisk
    ASTERISK
  end

  def match_all?
    self.eql? ASTERISK
  end

end
