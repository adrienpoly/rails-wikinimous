class Article < ApplicationRecord

  def extract(keywords = "")
    content[0..100]
  end
end
