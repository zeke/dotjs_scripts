# ==UserScript==
# @name          DICT.org Prettifier
# @namespace     http://queri.ac/zeke/oneoffs/greasemonkey
# @description   DICT.org provides a web interface to several freely available online dictionaries. The site's content is good, but the presentation is bad. This script removes the cruft and stylizes search results, making them more readable.
# @include       http://*dict.org/*
# ==/UserScript==

# Remove Header
# -----------------------------------------------------------------------------------
logo = document.getElementsByTagName("center")[0]
header_links = document.getElementsByTagName("p")[0]
logo.parentNode.removeChild logo
header_links.parentNode.removeChild header_links

# Tighten up the search form so it fits on a single horizontal line
# -----------------------------------------------------------------------------------

# Change the form's method from POST to GET
form = document.getElementsByTagName("form")[0]
form.setAttribute "method", "get"

# Collect the needed fields
f1 = document.getElementsByTagName("td")[1].innerHTML.replace("<br>", "")
f2 = document.getElementsByTagName("td")[3].innerHTML.replace("<br>", "")
f3 = document.getElementsByTagName("td")[5].innerHTML.replace("<br>", "")
f4 = "<input type=\"submit\" value=\"Search\" name=\"submit\"/>"

# Scrap the old fields
old_fields = document.getElementsByTagName("center")[1]
old_fields.parentNode.removeChild old_fields

# Add in the new fields
new_fields = document.createElement("span")
new_fields.innerHTML = f1 + f2 + f3 + f4
form.appendChild new_fields

# Clean up text styles
# -----------------------------------------------------------------------------------

# Create fresh div for each source/definition pair
sources = document.getElementsByTagName("b")
i = 0

while i < sources.length
  source = sources[i]
  if source.innerHTML.indexOf("From") is 0
    def = source.nextSibling
    div = document.createElement("div")
    div.innerHTML = "<h2>" + source.innerHTML.replace("From ", "").replace(":", "") + "</h2>"
    div.style.width = "500px"
    div.style.borderLeft = "5px solid #DDDDDD"
    div.style.paddingLeft = "10px"
    div.style.marginRight = "20px"
    div.style.marginRight = "20px"
    div.style.cssFloat = "left"
    document.body.appendChild div
    div.appendChild def
  i++

# Style the definitions
defs = document.getElementsByTagName("pre")
i = 0

while i < defs.length
  def = defs[i]
  def.style.color = "#333333"
  def.style.fontSize = "11px"
  def.style.lineHeight = "16px"
  def.style.fontFamily = "'Lucida Grande', Verdana"
  i++

# Style the sources
sources = document.getElementsByTagName("h2")
i = 0

while i < sources.length
  source = sources[i]
  source.style.color = "#666666"
  source.style.fontSize = "16px"
  source.style.fontWeight = "normal"
  source.style.fontFamily = "Georgia, Sans"
  i++

# Style all links
links = document.getElementsByTagName("a")
i = 0

while i < links.length
  link = links[i]
  link.style.color = "#0489B7"
  i++

# Remove Footer, horizontal rules, and bold stuff
# -----------------------------------------------------------------------------------
hrs = document.getElementsByTagName("hr")
i = 0

while i < hrs.length
  hr = hrs[i]
  hr.style.display = "none"
  i++
centers = document.getElementsByTagName("center")
footer = centers[centers.length - 1]
footer.parentNode.removeChild footer
bolds = document.getElementsByTagName("b")
i = 0

while i < bolds.length
  b = bolds[i]
  b.style.display = "none"
  i++