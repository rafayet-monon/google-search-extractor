require 'benchmark'

class BenchmarkNakama
  def self.benchmark
    n                  = 50_000
    params             = {}
    params[:daterange] = '2020/03/22 - 2020/03/22'
    user               = User.first

    Benchmark.bm do |benchmark|
      benchmark.report('Without ServiceNakama') do
        n.times do
          ReportService.perform(params, user)
        end
      end

      benchmark.report('With ServiceNakama') do
        n.times do
          ReportServiceWithNakama.perform(params, user)
        end
      end
    end
  end

end