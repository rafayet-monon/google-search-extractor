RSpec.describe FileServices::Initializer do
  let(:user) { FactoryBot.create(:user) }
  let(:params) { {} }

  context "When #{described_class} perform" do
    it "is expected to return instance of #{described_class}" do
      file_service = described_class.perform(params, user)

      expect(file_service).to be_an_instance_of(described_class)
    end

    it 'is expected to return error if no file given' do
      file_service = described_class.perform(params, user)

      expect(file_service.error).to eq('File must be present in CSV format!')
    end

    it 'is expected to return error if CSV type file not given' do
      params[:file] = fixture_file_upload('spec/files/upload_test.txt')
      file_service  = described_class.perform(params, user)

      expect(file_service.error).to eq('File must be present in CSV format!')
    end

    it 'is expected to return error if CSV type file is invalid' do
      params[:file] = fixture_file_upload('spec/files/keyword_invalid.csv', 'text/csv')
      file_service  = described_class.perform(params, user)

      expect(file_service.error).to eq('Your CSV file type is not supported!')
    end

    it 'is expected to return error if unexpected error occurs' do
      params[:file] = fixture_file_upload('spec/files/keyword_valid.csv', 'text/csv')
      file_service  = described_class.perform(params, User.last)

      expect(file_service.error).to eq('Something went wrong. Please try again!')
    end

    it 'is expected to create a new SearchFile record if CSV is valid' do
      params[:file] = fixture_file_upload('spec/files/keyword_valid.csv', 'text/csv')
      expect { described_class.perform(params, user) }.to change { SearchFile.count }.by(1)

      FileUtils.rm_rf(Dir["#{Rails.root}/file_uploads/csv_keywords/user_#{user.id}"])
    end
  end
end