# -*- coding: utf-8 -*-
class FeedsController < ApplicationController
  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = Feed.all
    @feed = Feed.new
    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @feeds }
    end
  end

  def last
    @entries = Entry.last(30)
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
    @feed = Feed.find(params[:id])
    @search = @feed.entries.search(params[:q])
    @entries = @search.result.order("published DESC").page params[:page]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feed }
    end
  end

  def dump
    @feeds = Feed.all
  end

  # GET /feeds/new
  # GET /feeds/new.json
  def new
    @feed = Feed.new
    @categories = Category.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feed }
    end
  end

  # GET /feeds/1/edit
  def edit
    @feed = Feed.find(params[:id])
    @categories = Category.all
  end

  # POST /feeds
  # POST /feeds.json
  def create
    @feed = Feed.new
    @feed.category_id = params[:feed][:category_id]
    @feed.feed_url = params[:feed][:feed_url].strip
    feed = Feedzirra::Feed.fetch_and_parse(@feed.feed_url)

    if feed.nil? or feed == 0
      render :new, notice: "Ce lien semble incorrect"
    else
      @feed.title = feed.title
      @feed.url = feed.url unless feed.url.nil?
      @feed.feed_url = feed.feed_url
      @feed.etag = feed.etag
      @feed.last_modified = feed.last_modified
      respond_to do |format|
        if @feed.save
          format.html { redirect_to @feed, notice: 'Feed was successfully added.' }
          format.json { render json: @feed, status: :created, location: @feed }
        else
          format.html { render action: "new" }
          format.json { render action: "new", notice: "Feed already registred." }
        end
      end
    end
  end

  # def add_many
  #   urls = params[:feed][:feed_url].split("\n")
  #   urls.each do |u|
      
  #   end
  # end

  def update_all
    Feed.all.each do |feed|
      feed.update_entries
    end
    redirect_to feeds_path
  end

  # PUT /feeds/1
  # PUT /feeds/1.json
  def update
    @feed = Feed.find(params[:id])

    respond_to do |format|
      if @feed.update_attributes(params[:feed])
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy

    respond_to do |format|
      format.html { redirect_to feeds_url }
      format.json { head :no_content }
    end
  end

  def mark_read_entry
    entry = Entry.find_by_id(params[:id])
    unless entry.nil?
      entry.unread = false
      entry.save
      f = entry.feed
      f.unread -= 1
      f.save
    end
    render nothing: true
  end

  def mark_read_feed
    @feed = Feed.find_by_id(params[:id])
    unless @feed.nil?
      @feed.entries.update_all(unread: false)
      @feed.unread = 0
      @feed.save
    end
    render nothing: true
  end

  # def mark_unread_entry
  #   entry = Entry.find_by_id(params[:id])
  #   unless entry.nil?
  #     entry.unread = true
  #     entry.save
  #     f = entry.feed
  #     f.unread += 1
  #     f.save
  #   end
  #   render nothing: true
  # end
end
