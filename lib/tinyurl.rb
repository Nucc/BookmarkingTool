require "uri"

module BookingTool

    # Proxy class for TinyURL to be able mock it out
    class TinyURL

        def initialize
            @url = ""
        end

        def use(url)
            @url = url
            self
        end

        def body
            tinyurl = URI.parse("http://tinyurl.com/")
            Net::HTTP.start(tinyurl.host, tinyurl.port) { |http|
                http.get("/api-create.php?url=" + @url)
            }.body
        end

    end

end