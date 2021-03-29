# frozen_string_literal: true

class Task < ApplicationRecord
  validates :description, presence: true

  validate :finished_at_time_added, on: :update
  def finished_at_time_added
    self.finished_at = DateTime.now
  end

  def finish
    self.finished  =true
    self.finished_at = DateTime.now
  end
end
