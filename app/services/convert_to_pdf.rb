# frozen_string_literal: true

# convert to pdf
class ConvertToPdf
  def initialize(file:)
    @file = file
  end

  def call
    @file.present?
  end
end
