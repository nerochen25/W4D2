class Cat < ApplicationRecord
  COLORS = ['Brown', 'Black', 'White', 'Yellow', 'Blue', 'Green']
  validates :color,
    presence: true,
    inclusion: COLORS

  SEX = ['M', 'F']
  validates :sex,
    presence: true,
    inclusion: SEX

  validates :name,
    presence: true

  validates :birth_date,
    presence: true

  has_many :rental_requests,
  foreign_key: :cat_id,
  class_name: :CatRentalRequest,
  dependent: :destroy

  def age
    now = Time.now.utc.to_date
    if now.month > self.birth_date.month
      return now.year - (self.birth_date.year - 1)
    else
      now.year - self.birth_date.year
    end
  end
end
