require 'routemaster'
require 'sinatra'
require 'rack/ssl'
require 'routemaster/middleware/authentication'
require 'routemaster/controllers/pulse'
require 'routemaster/controllers/topics'
require 'routemaster/controllers/subscription'
require 'routemaster/mixins/log_exception'

class Routemaster::Application < Sinatra::Base

  include Routemaster::Mixins::LogException

  configure do
    # Do capture any errors. We're logging them ourselves
    set :raise_errors, false
  end

  use Rack::SSL
  use Routemaster::Middleware::Authentication
  use Routemaster::Controllers::Pulse
  use Routemaster::Controllers::Topics
  use Routemaster::Controllers::Subscription

  not_found do
    content_type 'text/plain'
    body ''
  end

  error do
    deliver_exception env['sinatra.error']
  end

end
