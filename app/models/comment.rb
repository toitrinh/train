class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user



  validates :body, presence: true,
                    length: { minimum: 1 }

  def self.search(search, page)
  paginate :per_page => 2, :page => page,
           :conditions => ['body like ?', "%#{search}%"]
   end
end
