require 'sinatra'
require 'sinatra/activerecord'
require 'pry'

ENV['RACK_ENV'] ||= 'development'

ActiveRecord::Base.establish_connection( ENV['RACK_ENV'].to_sym )

set environment: ENV['RACK_ENV']

class SinatraApp < Sinatra::Base
  def self.pw_from_file pwfile
    fullpath = "/home/#{ENV['LOGNAME']}/#{pwfile}"
    File.exist?(fullpath) && IO::read(fullpath).strip
  end

  configure :production, :uat, :development, :test do
    enable :logging
  end
end

require "./config/environments/#{ENV['RACK_ENV']}"
