require 'sidekiq'
require 'sidekiq/web'

Sidekiq.default_worker_options['backtrace'] = true

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == %w[sidekiq sidekiq]
end