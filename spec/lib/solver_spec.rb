require 'spec_helper'
require 'solver'

RSpec.describe Solver do
  subject { described_class.new }

  it 'solves' do
    expect(subject.call(1, 2)).to eq(3)
  end
end
