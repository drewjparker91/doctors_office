require 'spec_helper'

describe '#Doctor' do 

  describe('.all') do
    it("returns an empty array when there are no doctors") do
      expect(Doctor.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves a doctor") do
      doctor = Doctor.new({:name => "Drew Parker", :specialty => "MD", :id => nil})
      doctor.save()
      doctor2 = Doctor.new({:name => "Adam Mansell", :specialty => "MD", :id => nil})
      doctor2.save()
      expect(Doctor.all).to(eq([doctor, doctor2]))
    end
  end

  describe('.clear') do
    it("clears all doctors") do
      doctor = Doctor.new({:name => "Drew Parker", :specialty => "MD", :id => nil})
      doctor.save()
      doctor2 = Doctor.new({:name => "Adam Mansell", :specialty => "MD", :id => nil})
      doctor2.save()
      Doctor.clear
      expect(Doctor.all).to(eq([]))
    end
  end

  
end