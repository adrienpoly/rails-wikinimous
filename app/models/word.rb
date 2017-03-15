class Word < ApplicationRecord
  validates :word, uniqueness: true
  include PgSearch

  pg_search_scope :search_word,
    against: :word,
    using: {
      tsearch: {
        prefix:     true,
        dictionary: "simple",
        tsvector_column: "tsv_word"
      }
    }

  pg_search_scope :search_word_index,
    against: :word_indexed,
    using: {
      tsearch: {
        prefix:     true,
        dictionary: "simple",
      }
    }
end
