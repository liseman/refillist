class Item < ActiveRecord::Base
  attr_accessible :amount, :description, :name, :shelf_id, :tag

  belongs_to :shelf
end
