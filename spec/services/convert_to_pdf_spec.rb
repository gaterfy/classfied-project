# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConvertToPdf, type: :service do
  include ActionDispatch::TestProcess::FixtureFile
  let(:file) { fixture_file_upload('spec/fixtures/computer.jpeg', 'image/jpeg') }
  let(:classfied) { FactoryBot.create(:classfied) }
  subject(:service) { described_class.new(file: file, resource: classfied) }

  describe '#call' do
    context 'when the request is success' do
      it 'returns the pdf', :vcr do
        expect(classfied.file.attached?).to eq false
        service.call
        expect(classfied.file.attached?).to eq true
        expect(classfied.file.blob.content_type).to eq 'application/pdf'
      end
    end
  end
end
