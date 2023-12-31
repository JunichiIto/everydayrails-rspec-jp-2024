class Project < ApplicationRecord
  validates :name, presence: true

  attribute :due_on, :date, default: -> { Date.current }
end
