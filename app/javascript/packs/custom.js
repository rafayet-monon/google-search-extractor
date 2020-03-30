$(document).on("turbolinks:click", function () {
    // show spinner on AJAX start
    $(".loader").show();
});

// hide spinner on AJAX stop
$(document).on("turbolinks:load", function () {
    $(".loader").hide();
});

$(document).on('ready page:load', function (event) {
    $(".loader").hide();
});

$(document).on('turbolinks:load', function (event) {
    $('input[name="daterange"]').daterangepicker({
        opens: 'left',
        locale: {
            format: 'YYYY/MM/DD'
        }
    });
});

$(document).on('turbolinks:load', function (event) {
    $("#search_file_file").change(function () {
        const file = this.files[0];
        const fileType = file['type'];
        if (fileType != 'text/csv') {
            toastr.error("Only CSV format is allowed");
            $(this).val('');
        }
    });

    $('#upload-csv-form').on('submit', function (e) {
        var file = $("#search_file_file").val();

        if (file === '') {
            e.preventDefault();
            toastr.error("Please select a file to upload!");
            return false;
        }
    });
});