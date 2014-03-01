class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates :title, presence: true,
                    length: { minimum: 5 }

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  


def self.search(search, page)
  paginate :per_page => 2, :page => page,
           :conditions => ['text like ?', "%#{search}%"],
           :order => 'text'
end


end
