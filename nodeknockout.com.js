score = $('div.star.filled').length/$('div.star').length;

// alert(score);

if (score && score > 0) {
  $("ul.team-stats").append("<li><div class='number'>" + score.toFixed(2) + "</div><div class='name'>Stars</div></li></ul>");
}

