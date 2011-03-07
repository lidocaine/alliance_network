# == Schema Information
# Schema version: 20110307204855
#
# Table name: microposts
#
#  id         :integer(4)      not null, primary key
#  content    :string(255)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :user
  
  validates :content, :presence => true,
                      :length => { :maximum => 140 }
  validates :user_id, :presence => true
  
  # Order posts by newest first by default
  default_scope :order => 'microposts.created_at DESC'
  
end
