require 'rails_helper'

RSpec.describe SearchFile, type: :model do

  context 'When SearchFile is created' do
    it { should validate_presence_of(:file_path) }
    it { should validate_presence_of(:file_name) }

    it 'is expected call FileProcessingWorker' do
      user = FactoryBot.create(:user)
      FactoryBot.create(:search_file, user_id: user.id)

      expect(FileProcessingWorker.jobs.size).to eq(1)
    end
  end
end
