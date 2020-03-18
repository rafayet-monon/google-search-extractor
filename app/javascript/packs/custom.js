$(document).on("turbolinks:click", function(){
    // show spinner on AJAX start
    $(".loader").show();
});

// hide spinner on AJAX stop
$(document).on("turbolinks:load", function(){
    $(".loader").hide();
});

$(document).on('ready page:load', function(event) {
    $(".loader").hide();
});