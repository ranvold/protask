# frozen_string_literal: true

class Task < ApplicationRecord
  enum :status, { new: 0, in_progress: 1, done: 2 }, default: :new

  belongs_to :project

  validates :name, presence: true
  validates :status, presence: true
end
