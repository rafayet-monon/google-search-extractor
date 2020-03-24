require 'rails_helper'

RSpec.describe SearchFile, type: :model do
  let(:file) { fixture_file_upload('spec/files/keyword_valid.csv', 'text/csv') }
  let(:upload_path) { Rails.root.join('spec', 'files') }

  context 'When SearchFile is created' do
    it { should validate_presence_of(:file_path) }
    it { should validate_presence_of(:file_name) }

    it 'is expected to call FileProcessingWorker' do
      FactoryBot.create(:search_file)

      expect(FileProcessingWorker.jobs.size).to eq(1)
    end
  end

  context 'when SearchFile object is initialized' do
    it 'is expected for "file_full_path" to return file valid path' do
      uploaded_path = FileServices::Uploader.perform(file, upload_path)
      search_file = FactoryBot.create(:search_file, file_path: uploaded_path)
      full_path = Pathname.new(search_file.file_full_path)
      expect(full_path).to exist

      File.delete(full_path)
    end
  end
end
