class SongPresenter < SimpleDelegator
  def author_ccli
    parts = []
    parts << author if author.present?
    parts << "CCLI #{ccli}" if ccli.present?

    parts.join " - "
  end
end
