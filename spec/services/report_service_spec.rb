RSpec.describe ReportService do
  let(:params) { {} }
  let(:user) { FactoryBot.create(:user) }

  context "When #{described_class} perform" do
    it "should return instance of #{described_class}" do
      report_service = described_class.perform(params, user)

      expect(report_service).to be_an_instance_of(described_class)
    end

    it 'should return no error if valid daterange given "2020/03/22 - 2020/03/22"' do
      params[:daterange] = '2020/03/22 - 2020/03/22'
      report_service     = described_class.perform(params, user)

      expect(report_service.error).to be(nil)
    end

    invalid_date_range_array = ['2020-03-22 - 2020-03-22', '02-02-2020 - 02-02-2020', '02/02/2020 - 02/02/2020',
                                '31/02/2020 - 31/02/2020', '31/02/20 - 31/02/20']
    invalid_date_range_array.each do |daterange|
      it "should return error if invalid daterange given #{daterange}" do
        params[:daterange] = daterange
        report_service     = described_class.perform(params, user)

        expect(report_service.error).to eq('Select a valid daterange!')
      end
    end
  end
end