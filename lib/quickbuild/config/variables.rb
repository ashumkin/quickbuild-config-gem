
module Quickbuild::Config

  class Variable
    attr_reader :name, :value

    def initialize(name, value)
      @name, @value = name, value
    end

    def eql?(object)
      name == object.name && value == object.value
    end

    def to_xml
      "<entry><string>#{name}</string><string>#{value}</string></entry>"
    end
  end

  class VariableList < Array

    def indent_count
      2
    end

    def indentation
      ' ' * indent_count
    end

    def to_xml
      result = []
      self.each do |var|
        result << indentation + var.to_xml
      end
      unless self.empty?
        result.unshift '<variables>'
        result << '</variables>' << ''
      end
      result.join("\n")
    end

  end

end
