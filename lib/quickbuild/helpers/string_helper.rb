class String
  ASTERISK = '*'
  HYPHEN = '-'

  def self.asterisk
    ASTERISK
  end

  def match_all?
    self.eql? ASTERISK
  end

  def as_xml_comment
    '<!-- %s -->' % self
  end

  def as_array
    split("\n")
  end

  def is_xml?
    as_array[0].to_s.match(/^<\?xml /)
  end

  def append_text_after_xml_header(text)
    (as_array.insert(1, text) << '').join("\n")
  end

  def inject_to_xml(configuration_path)
    if is_xml?
      append_text_after_xml_header(configuration_path.as_xml_comment)
    else
      self
    end
  end

  def is_stdout?
    eql?('') || eql?(HYPHEN)
  end

end
