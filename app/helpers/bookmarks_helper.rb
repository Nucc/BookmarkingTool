module BookmarksHelper

    def title_of(bookmark)
        (bookmark.title and bookmark.title.length > 0) ? bookmark.title : "No title"
    end

    def description_of(bookmark)
        bookmark.description ? bookmark.description : "No description"
    end

end
