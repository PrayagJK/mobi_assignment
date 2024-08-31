require 'rails_helper'

RSpec.describe Course, type: :model do
  it { should have_many(:tutors) }

  it "is valid with valid attributes" do
    course = build(:course)
    expect(course).to be_valid
  end

  it "is not valid without a name" do
    course = build(:course, name: nil)
    expect(course).to_not be_valid
  end
end
