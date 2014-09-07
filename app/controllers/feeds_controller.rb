require 'retrieve'

class FeedsController < ApplicationController
  before_filter :authenticate_user!

  def list
    @feeds = Feeds.all
  end

  def feed_params
    params.require(:feeds).permit(:name, :url)
  end

  def new_feed
    @add_feed = Feeds.new
  end

  def create
    @add_feed = Feeds.new(feed_params)
    if @add_feed.save
      redirect_to :feeds_list, :notice => "Feed has been saved successfully."
    else
      flash.now[:notice] = "Feed can not be saved, an error occurred"
      render :feeds_new_feed_path
    end
  end

  def run_feed
    @update = Updater.new
    @update.retrieval(params[:url], params[:name])
    if @update
      redirect_to :feeds_list, :notice => "Feed initiated successfully."
    else
      flash.now[:notice] = "Error: Cannot run feed at this time."
      render :feeds_list_path
    end
  end
  helper_method :update_feed

  def run_all_feeds
    # function to run every feed in feed_listing
  end

  def scheduler
    # function to keep track of feed scheduling
  end
end
