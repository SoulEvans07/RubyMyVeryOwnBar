class Cocktail < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  has_and_belongs_to_many :users
  has_and_belongs_to_many :ingredients

  validates :name, {presence: true}
  validates :img, {presence: true}

  before_save :normalize_blank_values

  def normalize_blank_values
    attributes.each do |column, value|
      self[column].present? || self[column] = nil
    end
  end

  def missing?
    missing = 0
    self.ingredients.each do |ingr|
      unless ingr.have
        missing += 1
      end
    end
    missing
  end
end
