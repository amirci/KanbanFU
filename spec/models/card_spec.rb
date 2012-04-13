require 'spec_helper'

describe Card do
  it { should validate_presence_of(:title) }
  it { should belong_to(:phase) }
end
