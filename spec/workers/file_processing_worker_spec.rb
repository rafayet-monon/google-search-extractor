# require 'rails_helper'
# require 'sidekiq/testing'
# Sidekiq::Testing.fake!

RSpec.describe FileProcessingWorker, type: :worker do
  before(:each) do
    file             = fixture_file_upload('spec/files/keyword_valid.csv', 'text/csv')
    upload_path      = Rails.root.join('spec', 'files')
    uploaded_path    = FileServices::Uploader.perform(file, upload_path)
    @search_file_obj = FactoryBot.create(:search_file, file_path: uploaded_path)
  end

  after(:each) do
    File.delete(@search_file_obj.file_full_path)
  end

  context "When #{described_class} initiated" do
    VCR.use_cassette 'selenium_google_request' do
      it 'is expected to return completed SearchFile' do
        completed_search_file_obj = described_class.new.perform(@search_file_obj.id)

        expect(completed_search_file_obj.status).to eq('completed')
      end
    end
    VCR.use_cassette 'selenium_google_request' do
      it 'is expected to create SearchResult' do
        completed_search_file_obj = described_class.new.perform(@search_file_obj.id)

        expect(completed_search_file_obj.search_results).to exist
      end
    end
  end
end