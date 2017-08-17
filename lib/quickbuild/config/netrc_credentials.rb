
module Quickbuild::Config

  class NetrcCredentials

    def get_credentials_for(uri)
      netrc = Netrc.read
      credentials = netrc[uri.host]
      return credentials.login, credentials.password if credentials
    end

  end

end
