# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

["Informatique / Technologie",
 "Actualité",
 "Divers"].each do |name|
  category = Category.new
  category.name = name
  category.save
end

[[1, "http://sebsauvage.net/rhaa/rss.php"],
 [1, "http://feeds.feedburner.com/geeksAreSexyTechnologyNews"],
 [2, "http://rss.lemonde.fr/c/205/f/3050/index.rss"],
 [2, "http://www.lefigaro.fr/rss/figaro_une.xml"],
 [2, "http://rss.feedsportal.com/c/568/f/9909/index.rss"],
 [1, "http://feeds.feedburner.com/ubergizmo_fr"],
 [1, "http://feeds.feedburner.com/hackaday/LgoM"],
 [1, "http://sebsauvage.net/links/index.php?do=rss"],
 [1, "http://stackoverflow.com/feeds"],
 [3, "http://feeds.feedburner.com/Koreus-articles"]].each do |f|
  print "* Feed: #{f[1]} "
  feed = Feed.new
  feed.category_id = f[0]
  feed.feed_url = f[1]
  fz = Feedzirra::Feed.fetch_and_parse(feed.feed_url)
  if fz.nil? or fz == 0
    puts "failed (reach)"
  else
    feed.title = fz.title
    feed.url = fz.url unless feed.url.nil?
    feed.feed_url = fz.feed_url
    feed.etag = fz.etag
    feed.last_modified = fz.last_modified
    if feed.save!
      puts "added!"
      
    else
      puts "failed (record)"
    end
  end
  Feed.all.each do |f|
    f.get_entries
  end
end
