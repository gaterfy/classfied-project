# frozen_string_literal: true

# convert to pdf
class ConvertToPdf
  def initialize(file:, resource: nil)
    @file = file
    @resource = resource
  end

  def call
    return unless @file.present?

    my_task = Ilovepdf::Tool::Imagepdf.new(ENV['PUBLIC_KEY'], ENV['SECRET_KEY'])

    # File object keeps information about its server_filename and the properties you can set
    my_task.add_file @file.tempfile
    # binding.pry

    my_task.execute

    attach_resource_file(pdf_file_string: my_task.download_info.output_file) if my_task.download
  end

  private

  def attach_resource_file(pdf_file_string:)
    return if @resource.nil?

    tempfile = Tempfile.new('converted.pdf')
    tempfile.binmode
    tempfile.write(pdf_file_string)
    tempfile.rewind
    @resource.file.attach(io: File.open(tempfile), filename: converted_file_name)
    @resource.save
    tempfile.close
  end

  def converted_file_name
    "#{@file.original_filename}.pdf"
  end
end
