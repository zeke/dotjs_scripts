// Generated by CoffeeScript 1.4.0
(function() {
  var forkList;

  $('#js-repo-pjax-container').prepend("<ol id='forks'></ol>");

  forkList = $("#forks");

  $('a.social-count').on('click', function() {
    var pathParts, repo, url, user;
    pathParts = location.pathname.match(/\/+([^/]*)\/([^(/|\?)]*)/);
    if (!(pathParts && pathParts.length === 3)) {
      return false;
    }
    user = pathParts[1];
    repo = pathParts[2];
    url = "https://api.github.com/repos/" + user + "/" + repo + "/forks?per_page=1000&sort=watchers";
    $.getJSON(url, function(forks) {
      var fork, _i, _len;
      forks.sort(function(a, b) {
        if (a.forks === b.forks) {
          return 0;
        } else if (a.forks < b.forks) {
          return 1;
        } else {
          return -1;
        }
      });
      for (_i = 0, _len = forks.length; _i < _len; _i++) {
        fork = forks[_i];
        forkList.append("        <li>          <span class='name'><a href='" + fork.html_url + "'>" + fork.full_name + "</a></span>          <span class='count'><em>" + fork.watchers + "</em> watchers</span>          <span class='count'><em>" + fork.forks + "</em> forks</span>        </li>      ");
      }
      $('#forks').css({
        listStyle: 'none',
        margin: '20px 0'
      });
      $('#forks > li').css({
        padding: '10px 0',
        borderBottom: "1px solid #DDD"
      });
      $('#forks > li > span').css({
        display: "inline-block"
      });
      $('#forks > li > span.name').css({
        minWidth: "500px",
        maxWidth: "600px"
      });
      $('#forks > li > span.count').css({
        color: "#999",
        minWidth: "80px"
      });
      return $('#forks > li > span.count em').css({
        color: "#000",
        fontStyle: "normal"
      });
    });
    return false;
  });

}).call(this);
