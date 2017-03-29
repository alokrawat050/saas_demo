require 'rails_helper'

describe CompanyMaster do
  describe 'validations' do
    it { should validate_presence_of :company_name}
    it { should validate_uniqueness_of :company_name}
    
    it { should allow_value('abcmart').for(:company_name) }
    it { should allow_value('test').for(:company_name) }
    
    it { should_not allow_value('www').for(:company_name) }
    it { should_not allow_value('WWW').for(:company_name) }
    it { should_not allow_value('.test').for(:company_name) }
    it { should_not allow_value('test/').for(:company_name) }
    
    it 'should validate case insensitive uniqueness' do
        create(:company_master, company_name: 'Test')
        expect(build(:company_master, company_name: 'test')).to_not be_valid
    end
  end
  
  describe 'associations' do
    it 'should have owner'
  end
end