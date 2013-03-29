// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

function mark_read(entry_id, feed_id)
{
    // ajax
    tocall = "/entries/" + entry_id + "/mark_read";
    $.ajax({
	url: tocall,
	success: function(nb){
	    // update unread entries
	    feed = $('#sidebar_' + feed_id + '_unread')
	    entry_link = $('#entry_' + entry_id + '_mark_read')
	    navbar_unread = $('#navbar_unread')
	    navbar_unread_content = $('#navbar_unread_content')
	    page_title = $('title')
	    feed.text(nb);
	    if (feed.text() == "0")
		feed.fadeOut();
	    entry_link.fadeOut();
	    navbar_unread_content.text(navbar_unread_content.text() - 1);
	    if (navbar_unread_content.text() == "0")
	    {
		navbar_unread.fadeOut();
		page_title.text("SakiMonkey");
	    }
	    else
		page_title.text("SakiMonkey (" + navbar_unread_content.text() + ")");
	}
    });
    return false;
}

$(document).ready(function() {
    $('img.favicon').error(function() {
        this.src = '/default-favicon.png';
    });
});
