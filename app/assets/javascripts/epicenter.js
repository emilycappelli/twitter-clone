// Turbo links is a gem that makes the page load faster. Turbolinks can load stuff at other times. 
$(document).on('turbolinks:load', function() {
	$('#unfollow-btn').hover(function() {
		$(this).removeClass('btn-primary');
		$(this).addClass('btn-danger');
		$(this).html("Unfollow");
	}, function() {
		// what to do on hover-off
		$(this).removeClass('btn-danger');
		$(this).addClass('btn-primary');
		$(this).html("Following");
	});
})
