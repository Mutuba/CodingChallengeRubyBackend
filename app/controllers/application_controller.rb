class ApplicationController < ActionController::API
  include JsonResponse

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found(error)
    json_response({
                    "error": error.message
                  })
  end
end
