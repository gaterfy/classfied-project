# frozen_string_literal: true

# convert to pdf
class ConvertToPdf
  def initialize(file:)
    @file = file
  end

  def call
    return unless @file.present?

    my_task = Ilovepdf::Tool::Imagepdf.new(ENV['PUBLIC_KEY'], ENV['SECRET_KEY'])

    # File object keeps information about its server_filename and the properties you can set
    my_task.add_file file.file_path

    my_task.execute
  end
end
