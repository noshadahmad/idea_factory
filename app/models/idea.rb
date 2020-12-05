class Idea < ApplicationRecord
    has_many :reviews, dependent: :destroy

    belongs_to :user, optional: true


    before_save :capitalize_title

    validates :title, presence: true

    validates :description, presence: true



    
    def capitalize_title
        self.title.capitalize!
    end
end
