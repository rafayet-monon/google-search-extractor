require 'rails_helper'

RSpec.describe SearchResult, type: :model do
  context 'When SearchResult is created' do
    it { should validate_presence_of(:key) }
    it { should validate_presence_of(:results) }
    it { should validate_presence_of(:links) }
    it { should validate_presence_of(:ad_words) }
    it { should validate_presence_of(:html) }
  end
end
