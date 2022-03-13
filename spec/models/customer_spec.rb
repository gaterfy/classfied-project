# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer, type: :model do
  subject { FactoryBot.build(:customer) }

  it { is_expected.to be_valid }
  it { is_expected.to have_many(:classfieds) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_numericality_of(:rating) }
end
