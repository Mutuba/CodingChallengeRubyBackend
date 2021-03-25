# frozen_string_literal: true

class Task < ApplicationRecord
  validates :description, presence: true
end
