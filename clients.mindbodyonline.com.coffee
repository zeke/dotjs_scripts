window.log = ->
  console.log.apply console, arguments if window.console

courses = []
fields = ['startTime', 'className', 'trainerName', 'duration', 'location']
headers = {}
day = null

for field in fields
  headers[field] = $("##{field}Header").index()

$("#classSchedule-mainTable tr").each ->
  
  if $(this).find("td.header").length > 0
    day = $(this).find("td.header").text().trim()

  course = {}
  course.day = day
  for name, index of headers when index isnt -1
    course[name] = $(this).find("td:eq(#{index})").text().trim()#.split(" (")[0]

    if name is 'trainerName'
      id = $(this).find("td:eq(#{index}) a").attr('name')
      course.trainerId = id.replace("bio", "") if id?
    
  courses.push course

log(courses.length)
log(courses)
# log(JSON.stringify(courses))