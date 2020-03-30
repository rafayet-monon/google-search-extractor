require 'rails_helper'

RSpec.describe User, type: :model do
  let(:search_file) { FactoryBot.create(:search_file) }

  context 'when User id deleted' do
    it 'is expected to destroy associated search files' do
      User.find(search_file.user_id).destroy

      expect { search_file.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
