class Project < ApplicationRecord
  validates :name, presence: true

  belongs_to :owner, class_name: 'User', foreign_key: :user_id

  attribute :due_on, :date, default: -> { Date.current }
end
