// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function () {
  $yearInput = $('input[name=year]');
  $yearInput.on('input', function() {
    var year = parseInt($yearInput.val());

    if(year > 1990) {
      $('#calculationMethodBoxes').show();
    }
    else {
      $('#calculationMethodBoxes').hide();
    }
  });
});
