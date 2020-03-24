RSpec.describe SearchServices::GoogleExtractor do
  let(:keyword) { 'search' }

  context "When #{described_class} perform" do
    it "should return instance of #{described_class}" do
      VCR.use_cassette 'selenium_google_request' do
        google_service = described_class.perform(keyword)

        expect(google_service).to be_an_instance_of(described_class)
      end
    end
  end
end