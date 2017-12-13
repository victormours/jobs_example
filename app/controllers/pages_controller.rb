class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :tweet]

  def home
  end

  def tweet
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["CONSUMER_KEY"]
      config.consumer_secret     = ENV["CONSUMER_SECRET"]
      config.access_token        = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_SECRET"]
    end

    time = I18n.localize(Time.now, format: "%H:%H:%S")
    client.update("It's #{time}, and some day I'll visit #{Faker::Address.street_name}.")

    flash[:notice] = "You just tweeted something!"
    redirect_to root_path
  end

end
