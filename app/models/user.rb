class User < ActiveRecord::Base 
    has_secure_password
    has_many :lists

    enum category: [ :arts_and_entertainment, :sports, :politics_and_history, :food, :recreation, 
                     :business, :other ]
         
    def slug
        self.username.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
        User.all.find do |user|
            user.slug == slug
        end
    end
end
