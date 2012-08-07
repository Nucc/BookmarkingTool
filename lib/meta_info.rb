require "metainspector"

module Bookmarking

    # Proxy class for MetaInspector to be able mock it out
    class MetaInfo

        def initialize
        end

        def info(url)
            @inspector = MetaInspector.new(url)
        end

        def method_missing(method, *args, &block)
            @inspector.send(method, *args, &block) if @inspector
        end

    end

end