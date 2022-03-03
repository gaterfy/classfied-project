# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConvertToPdf, type: :service do
  let(:file) { 'spec/fixtures/computer.png' }
  subject(:service) { described_class.new(file: file) }

  describe '#call' do
    context 'when the request is success' do
      it 'returns the pdf' do
        service.call
        # expect { service }.to change(Pokemon, :count).from(0).to(1)
      end
    end
  end
end
