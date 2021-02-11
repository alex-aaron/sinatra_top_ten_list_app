class List < ActiveRecord::Base 
    belongs_to :user

    enum category: [ :arts_and_entertainment, :sports, :politics_and_history, :food, :recreation, 
                     :business, :math_and_sciences, :geography, :other ]
end