class Frustration < ActiveRecord::Base
    belongs_to :user
    has_many :comments, :dependent => :destroy
    
    default_scope :order => 'created_at DESC'
    
    validates :content , :length => { in: 5..500 }
    #validates_format_of :content, :with => /^href/, :on => :create
end
