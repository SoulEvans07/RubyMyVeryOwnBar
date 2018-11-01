class Notification < ApplicationRecord
  belongs_to :user

  def type_string
    case self.item_type
    when 0
      "cocktail"
    when 1
      "ingredient"
    else
      raise "Cannot get type: wrong item type"
    end
  end

  def get_item
    case self.item_type
    when 0
      Cocktail.find_by_id(self.item)
    when 1
      Ingredient.find_by_id(self.item)
    else
      raise "Cannot get item: wrong item type"
    end
  end

  def get_sender
    User.find_by_id(self.sender)
  end
end
