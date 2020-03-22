RSpec.describe SearchServices::GoogleExtractor do
  before(:all) do
    Rails.cache.clear
  end
  let(:keyword) { 'already' }

  context "When #{described_class} perform" do
    it "should return instance of #{described_class}" do
      VCR.use_cassette 'selenium_google_request', record: :new_episodes do
        google_service = described_class.perform(keyword)

        expect(google_service).to be_an_instance_of(described_class)
      end
    end
  end
end