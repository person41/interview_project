$(function () {
  $tableElement = $('table[data-logs-path]');
  if ($tableElement.length > 0) { //dummy check to verify that we are on the correct page
     setInterval(function(){
       $.get($tableElement.data('logs-path'), function() {
         console.log("pulled data")
       });
     }, 10000);
  }
});
