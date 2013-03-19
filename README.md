Information
-----------

**Project:** SakiMonkey

**Author:** Younes SERRAJ (yoones)

**URL:** https://github.com/yoones/sakimonkey

**License:** MIT

**Type:** Ruby on Rails application

**Description:**

RSS reader. You can manage your feeds, gather them in categories, search, etc. Feeds' entries caching is currently manual (you have to click the "Feeds update" button), but is to be replaced by a crontab-based solution.

Installation
------------

Just download sakimonky, go to the application folder and do:

$> bundle install

$> rake db:migrate

That's all. If you want some default feeds to try the app, do:

$> rake db:seed

Issues
------

For Ubuntu users:
If, during the "bundle" execution, you encounter dependencies issues with crub (through feedzirra), do:

$> sudo apt-get install libcurl3 libcurl3-gnutls libcurl4-openssl-dev
