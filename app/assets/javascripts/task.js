
function fillParameters() {
        if ($('#type option:selected').val() == 'Large') {
            document.getElementById("percent").style.display = "inline-block";
            $("#percent").prop("disabled", false);
            $("#until").prop("disabled", true);
            $("#since").prop("disabled", true);
            document.getElementById("since").style.display = "none";
            document.getElementById("until").style.display = "none";
            $("option[value='In progress']").each(function() {
                $(this).remove();
            });
            $('#state').append($('<option>', {
                value: 'In progress',
                text: 'In progress'
            }));
            $("option[value='Expired']").each(function() {
                $(this).remove();
            });
        }
        else if ($('#type option:selected').val() == 'Temporary') {
			document.getElementById("since").style.display = "inline-block";
			document.getElementById("until").style.display = "inline-block";
            document.getElementById("percent").style.display = "none";
            $("#until").prop("disabled", false);
            $("#since").prop("disabled", false);
            $("#percent").prop("disabled", true);
            $("option[value='Expired']").each(function() {
                $(this).remove();
            });
            $('#state').append($('<option>', {
                value: 'Expired',
                text: 'Expired'
            }));
            $("option[value='In progress']").each(function() {
                $(this).remove();
            });
        } else{
        	document.getElementById("since").style.display = "none";
			document.getElementById("until").style.display = "none";
			document.getElementById("percent").style.display = "none";
            $("#until").prop("disabled", true);
            $("#since").prop("disabled", true);
            $("#percent").prop("disabled", true);
            $("option[value='In progress']").each(function() {
                $(this).remove();
            });
            $("option[value='Expired']").each(function() {
                $(this).remove();
            });
        }
}



$(document).ready(function () {
    // handling type of task
    fillParameters();
    $('#type').change(fillParameters);
});