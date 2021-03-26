# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  # Validation tests
  # ensure columns description are present before saving
  it { should validate_presence_of(:description) }
end
