module BookmarksHelper

    def title_of(bookmark)
        bookmark.title.presence || "No title"
    end

    def description_of(bookmark)
        bookmark.description || "No description"
    end

end
