Warning
-------

This version is functional but is not ready for production !

Information
-----------

**Project:** SakiMonkey  
**Author:** Younes SERRAJ (yoones)  
**URL:** https://github.com/yoones/sakimonkey  
**License:** MIT License  
**Language/Framework:** Ruby on Rails application  
**Description:**  
> SakiMonkey is a RSS reader I started when I heard Google Reader would be shut down.  
It is free/open source software! It allows you to manage your feeds, gather them into categories, search, etc.

Note about the cache:  
Feeds' entries caching is done either manually (by clicking the "Update cache" button), or using whenever (a crontab-based gem).  
This app needs to be optimized. If you have any suggestion, feel free to use Github's tools to let me know/contribute.

Installation
------------

Just download sakimonky, go to the application folder and do:  
$> bundle install  
$> rake db:migrate  
That's all.

If you want some default feeds to try the app, do:  
$> rake db:seed

If you want to setup a daemon that updates your feeds, first configure 'config/schedule.rb' (by default updates the feeds every 2 minutes on development stage). Then, update your crontab using:  
$> whenever --update-crontab

This action requires that you are at the root of your rails application (it tries to access ./config/schedule.rb and expects to find it).

Issues
------

For Ubuntu users:

If, during the "bundle" execution, you encounter dependencies issues with crub (through feedzirra), do:  
$> sudo apt-get install libcurl3 libcurl3-gnutls libcurl4-openssl-dev

Please report any bug you find using Github tickets, that would be much appreciated!
