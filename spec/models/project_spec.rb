require 'spec_helper'

describe Project do
  it { should have_many(:phases).dependent(:destroy) }
  it { should have_many(:cards) }

  it { should validate_presence_of(:name) }
end
