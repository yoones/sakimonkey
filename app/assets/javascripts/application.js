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
	    feed.text(nb);
	    // hide link code
	    entry_link.fadeOut();
	}
    });
    return false;
}

$(document).ready(function() {
    $('img.favicon').error(function() {
        this.src = '/default-favicon.png';
    });
});
