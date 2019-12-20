require File.dirname(__FILE__) + '/app'

# For sending PUT/DELETE requests using a form with hidden input.
# <input type="hidden" name="_method" value="PUT">
# (Comes with Sinatra::Application, but must add it explicitly with Sinatra::Base)
use Rack::MethodOverride

run SinatraApp
