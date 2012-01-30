setInterval(
  function hideReplies() {
    $('div.js-stream-item').each(function() {
      if ($(this).find("p.js-tweet-text").text().indexOf('@') == 0) {
        $(this).css({
          opacity: .5
        });      
      }
    });
  }, 500
);