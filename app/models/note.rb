class Note < ActiveRecord::Base
  has_many :children, class_name: "Note", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Note"
end
