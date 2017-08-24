
module Quickbuild::Config

  class NetrcCredentials

    def get_credentials_for(uri)
      netrc = Netrc.read
      credentials = netrc[uri.host]
      return {login: credentials.login, password: credentials.password} if credentials
    end

  end

end
