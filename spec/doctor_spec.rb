require 'spec_helper'

describe '#Doctor' do 

  describe('.all') do
    it("returns an empty array when there are no doctors") do
      expect(Doctor.all).to(eq([]))
    end
  end



end