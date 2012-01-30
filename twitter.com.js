// Check for tweets that start with '@' and quiet 'em down a bit.
// Here's what it looks like: http://cl.ly/Dl86
setInterval(
  function() {
    $('div.js-stream-item').each(function() {
      if ($(this).find("p.js-tweet-text").text().indexOf('@') == 0) {
        $(this).css({
          opacity: .5
        });      
      }
    });
  }, 500
);