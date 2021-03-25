# frozen_string_literal: true

# app/services/application_service.rb
class ApplicationService
  # expects any number of args and
  # a block that implements an operation on the args
  def self.call(*args)
    new(*args).call
  end
end
