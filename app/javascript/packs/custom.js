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

$(document).on('turbolinks:load', function(event) {
    $('input[name="daterange"]').daterangepicker({
        opens: 'left',
        locale: {
            format: 'YYYY/MM/DD'
        }
    });
});