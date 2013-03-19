Warning
-------

This version isn't ready for production !

Information
-----------

**Project:** SakiMonkey

**Author:** Younes SERRAJ (yoones)

**URL:** https://github.com/yoones/sakimonkey

**License:** MIT

**Type:** Ruby on Rails application

**Description:**

RSS reader. You can manage your feeds, gather them in categories, search, etc. Feeds' entries caching is done either manually (by clicking the "Feeds update" button), or using whenever (a crontab-based gem).

Installation
------------

Just download sakimonky, go to the application folder and do:

$> bundle install

$> rake db:migrate

That's all. If you want some default feeds to try the app, do:

$> rake db:seed

If you want to setup a daemon that updates your feeds, first configure 'config/schedule.rb' (by default updates the feeds every 2 minutes on development stage). Then, update your crontab using:

$> whenever --update-crontab

This action requires that you are at the root of your rails application (it tries to access ./config/schedule.rb and expects to find it).

Issues
------

For Ubuntu users:
If, during the "bundle" execution, you encounter dependencies issues with crub (through feedzirra), do:

$> sudo apt-get install libcurl3 libcurl3-gnutls libcurl4-openssl-dev
