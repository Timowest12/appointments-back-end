class Item < ApplicationRecord
    has_many :reservations
    has_many :users, through: :reservations
    has_one_attached :image
    
    validates :name, presence: true
    validates :price, presence: true
    validates :description, presence: true
    validates :image, presence: true
    
    def self.search(search)
        where("name ILIKE ?", "%#{search}%")
    end
end
