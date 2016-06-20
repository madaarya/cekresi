require 'spec_helper'

describe Cekresi do
  it 'has a version number' do
    expect(Cekresi::VERSION).not_to be nil
  end

  it 'give status error when tracking code not found' do
    result = Cekresi.fetch("CGKC903017981610")
    expect(result).to include({status: :not_found})
  end

  it 'give status ok when tracking found' do
    result = Cekresi.fetch("CGKSZ00588203216")
    expect(result).to include({status: :ok})
  end

end
