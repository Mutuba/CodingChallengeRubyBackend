# frozen_string_literal: true

class Task < ApplicationRecord
  validates :description, presence: true

  def finish
    self.finished = true
    self.finished_at = DateTime.now
  end
end
