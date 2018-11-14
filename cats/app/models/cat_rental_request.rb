class CatRentalRequest < ApplicationRecord
  STATUSES = ['APPROVED','DENIED', 'PENDING']
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, inclusion: STATUSES
  validate :overlapping_requests
  belongs_to :cat,
  foreign_key: :cat_id,
  class_name: :Cat

  def overlapping_requests
    approved_requests = CatRentalRequest.where(cat_id: self.cat_id).where(status: 'APPROVED')
    overlaps = approved_requests.where.not('start_date > ? OR end_date < ?', self.end_date, self.start_date)
    unless overlaps.empty?
      self.errors[:date] << "conflicts with pre-existing approved request"
    end
  end

end
