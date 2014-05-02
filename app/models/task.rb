class Task < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :priority, numericality: true
  # validates :complete, inclusion: { in: [true, false] }

  scope :by_user, -> (user) { where(user_id: user.id).order(:priority) }
end
