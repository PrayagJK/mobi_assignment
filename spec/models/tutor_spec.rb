require 'rails_helper'

RSpec.describe Tutor, type: :model do
  it { should belong_to(:course) }

  it "is valid with valid attributes" do
    tutor = build(:tutor)
    expect(tutor).to be_valid
  end

  it "is not valid without a first name" do
    tutor = build(:tutor, first_name: nil)
    expect(tutor).to_not be_valid
  end


  it "is not valid without a last name" do
    tutor = build(:tutor, second_name: nil)
    expect(tutor).to_not be_valid
  end
end