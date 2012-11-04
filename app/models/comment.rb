class Comment < ActiveRecord::Base
    belongs_to :frustrations
    validates_presence_of :content, :frustration_id
end
