require 'spec_helper'

describe Phase do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:project) }
  it { should have_many(:cards) }
end
