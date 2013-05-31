# Are we on a repo network page?
pathParts = location.pathname.match(/\/+([^/]*)\/([^(/|\?)]*)\/network/)
return false unless pathParts

# Set up DOM container
$('#js-repo-pjax-container').prepend("<ol id='forks'></ol>")
forkList = $("#forks")

# Assemble forks API URL
user = pathParts[1]
repo = pathParts[2]
url = "https://api.github.com/repos/#{user}/#{repo}/forks?per_page=1000&sort=watchers"

$.getJSON url, (forks) ->

  if forks.length is 0
    forkList.append("<li>No forks found. :(</li>")
    return

  # Sort by fork count
  forks.sort (a, b) ->
    if a.forks is b.forks then 0 else if a.forks < b.forks then 1 else -1

  for fork in forks
    forkList.append "
      <li>
        <span class='name'><a href='#{fork.html_url}'>#{fork.full_name}</a></span>
        <span class='count'><em>#{fork.watchers}</em> watchers</span>
        <span class='count'><em>#{fork.forks}</em> forks</span>
      </li>
    "

  # Styling must be applied _after_ elements have been rendered.
  $('#forks').css
    listStyle: 'none'
    margin: '10px 0 10px 0'

  $('#forks > li').css
    padding: '10px 0'
    borderBottom: "1px solid #DDD"

  $('#forks > li > span').css
    display: "inline-block"

  $('#forks > li > span.name').css
    minWidth: "500px"
    maxWidth: "600px"

  $('#forks > li > span.count').css
    color: "#999"
    minWidth: "100px"

  $('#forks > li > span.count em').css
    color: "#000"
    fontStyle: "normal"