# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.build(:user) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:firstname) }
  it { is_expected.to validate_presence_of(:lastname) }
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_presence_of(:password_digest) }
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_uniqueness_of(:username) }
  it { is_expected.to have_many(:classfieds) }
end
