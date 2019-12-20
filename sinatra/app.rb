require 'sinatra/base'
require 'sinatra/flash'
require './config/environments'
Dir.glob('./lib/*.rb').each { |f| require f }
Dir.glob('./models/**/*.rb').each { |f| require f }
Dir.glob('./helpers/**/*.rb').each { |f| require f }

class SinatraApp < Sinatra::Base
  enable :sessions # (Sinatra sessions, not Globex sessions)
  enable :inline_templates
  register Sinatra::Flash

  set :root, File.dirname(__FILE__)
  set :session_secret, (ENV['SESSION_SECRET'] || 'b3823f6adf24b35efe3a60b38392666c')

  before do
    logger.info 'METHOD=' + request.request_method + ', PARAMS: ' + params.inspect

    username = request.env['HTTP_SSO_USER']
    username = ENV['TEST_USER_OVERRIDE'] if ENV['TEST_USER_OVERRIDE']
    if username.nil? or username.strip.empty?  # E.g., a blank login
      @user = User.new login: '(no sso user defined)'
      @error = "No login supplied"
      halt erb :unauthorized, layout: false
    end

    @user = User.find_or_create_by login: username.downcase
    if not @user.valid?  # E.g., a blank login
      @error = "Invalid login"
      halt erb :unauthorized, layout: false
    end
  end

  get '/?' do; erb :index end

  not_found do; status 404 end

  Dir.glob('./controllers/**/*.rb').each { |f| require f }
end

__END__

@@ unauthorized
<%= session[:impersonated_user] = nil %>
<%= session[:impersonating_user] = nil %>
<h2><span class="error_msg">Unable to login '<%= @user.login %>': <%= @error %></span></h2>
