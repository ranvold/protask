# frozen_string_literal: true

class Task < ApplicationRecord
  enum :status, { ready_to_go: 0, in_progress: 1, done: 2 }, default: :ready_to_go

  belongs_to :project

  validates :name, presence: true
  validates :status, presence: true

  scope :by_status, ->(status) { where(status:) }
end
