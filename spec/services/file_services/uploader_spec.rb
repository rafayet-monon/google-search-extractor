RSpec.describe FileServices::Uploader do
  let(:csv_file) { fixture_file_upload('spec/files/keyword_valid.csv', 'text/csv') }
  let(:csv_upload_path) { Rails.root.join('spec', 'files') }

  context "When #{described_class} perform" do
    it 'is expected to return valid uploaded file path' do
      file_path = described_class.perform(csv_file, csv_upload_path)
      full_path = Pathname.new(Rails.root.to_s + file_path.to_s)
      expect(full_path).to exist

      File.delete(full_path)
    end
  end
end