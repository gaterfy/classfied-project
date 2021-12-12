# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Classfied, type: :model do
  let(:classfied) { FactoryBot.create(:classfied) }

  it { is_expected.to be_valid }
  it { is_expected.to belongs_to(:user) }
  it { is_expected.to validates_presence_of(:user) }
end
