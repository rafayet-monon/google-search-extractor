RSpec.describe SearchServices::Initializer do
  let(:keyword) { 'search' }
  let(:file_obj) { FactoryBot.create(:search_file) }

  context "When #{described_class} perform" do
    it 'is expected to create a new SearchResult record' do
      VCR.use_cassette 'selenium_google_request' do
        expect { described_class.perform(keyword, file_obj) }.to change { SearchResult.count }.by(1)
      end
    end
  end
end