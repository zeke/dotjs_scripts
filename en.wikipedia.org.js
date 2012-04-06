// Find all the links in the page, get their text, and sort alphabetically.
links = jQuery.unique( $('#bodyContent a').map(function() { return $(this).text(); }).get() ).sort();

// Create a new element at the bottom of the page to store the link texts
$('#bodyContent').append("<p>" + links.join("; ") + "</p>");

// Give the new element some style
$('#bodyContent p:last').css({
  padding: '20px 0'
});
