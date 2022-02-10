# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Classfied, type: :model do
  subject { FactoryBot.create(:classfied) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_numericality_of(:price) }
end
