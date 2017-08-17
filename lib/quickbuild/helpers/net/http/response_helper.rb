
module Net

  class HTTPResponse

    def ok?
      self.class < Net::HTTPSuccess
    end

  end

end
