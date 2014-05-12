require 'sinatra'
require 'sinatra/reloader'
require 'securerandom'
require 'base64'
require 'json'

get '/' do

  form_api_secret = 'lRJmqjI19GxB80KJc7y7NOcI+8g=';

  opts = {};
  @bucket = opts['bucket'] = 'devel'
  opts['save-key'] =  "/{year}{mon}/{random}{.suffix}"
  opts['expiration'] = Time.now.to_i + 600
  opts['return-­url'] = 'http://upyun.form.xiguashe.com/return'
  
  @policy = Base64.encode64(opts.to_json).gsub(/\n/,'')
  @sign =  Digest::MD5.hexdigest("#{@policy}&#{form_api_secret}")


  erb :index
end

get '/return' do 
  @img_url =  params['url']
  erb :return
end  