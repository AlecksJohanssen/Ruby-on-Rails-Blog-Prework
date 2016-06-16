class Article < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :impressions, :as=>:impressionable
  validates_presence_of :title
  validates_presence_of :body
  def impression_count
    impressions.size
  end
  def unique_impression_count
    impressions.group(:ip_address).size 
  end
  def self.search(query)
    where("title like ?", "%#{query}%") 
  end
 def tag_list
  self.tags.collect do |tag|
    tag.name
  end.join(", ")
end
    def tag_list=(tags_string)
        tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
  new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
  self.tags = new_or_found_tags
end
end
