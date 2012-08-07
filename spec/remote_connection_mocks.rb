require "meta_info.rb"
require "tinyurl.rb"

module BookmarkingMocks

    class MetaInfo
        attr_accessor :title
        attr_accessor :description

        def info(url)
            self
        end
    end

    class TinyURL
        attr_accessor :body

        def use(url)
            @body = "tinyurl.com/default" unless @body
            self
        end
    end

end