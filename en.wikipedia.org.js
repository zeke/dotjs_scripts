links = jQuery.unique( $('#bodyContent a').map(function() { return $(this).text(); }).get() ).sort();

$('#bodyContent').append("<p>" + links.join("; ") + "</p>");

// console.log(links.join("\n"));

$('#bodyContent p:last').css({
  padding: '20px 0'
});
