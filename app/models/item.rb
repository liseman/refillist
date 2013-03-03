class Item < ActiveRecord::Base
  attr_accessible :amount, :description, :name, :shelf_id, :tag, :item_image

  belongs_to :shelf
#  has_attached_file :item_image, :styles => { :std => "100x100>" }, :default_url => "http://placehold.it/100x100"

end
