# frozen_string_literal: true

module Cloudinary
  class ImageUploadService < ApplicationService
    attr_reader :image_file

    def initialize(params)
      super()
      @image_file = params.fetch(:avatar)
    end

    def call
      upload_image(image_file)
      results
    end

    private

    def upload_image(image_file)
      @response = Cloudinary::Uploader.upload(image_file)
    end

    def results
      OpenStruct.new(result: result)
    end

    def result
      {
        image_url: @response['url']
      }
    end
  end
end
