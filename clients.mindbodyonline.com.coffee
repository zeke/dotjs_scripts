window.log = ->
  console.log.apply console, arguments if window.console

courses = []
fields = ['startTime', 'className', 'trainerName', 'duration', 'locationName']
headers = {}
day = null

# Get column indices
for field in fields
  headers[field] = $("##{field}Header").index()

$("#classSchedule-mainTable tr").each ->
  
  if $(this).find("td.header").length > 0
    day = $(this).find("td.header").text().trim()

  course = {}
  course.day = day
  course.location = document.title.replace(" Online", "")
    
  # For all fields for which a column exists...
  for name, index of headers when index isnt -1
    course[name] = $(this).find("td:eq(#{index})").text().trim()#.split(" (")[0]

    switch name
      when 'className'
        # Look for classId in name attribute
        id = $(this).find("td:eq(#{index}) a").attr('name')
        course.classId = id.replace("cid", "") if id?
      when 'trainerName'
        # Look for trainerId in name attribute
        id = $(this).find("td:eq(#{index}) a").attr('name')
        course.trainerId = id.replace("bio", "") if id?
      when 'locationName'
        # Append more specific location to existing location
        if course.locationName?
          course.location += ": #{course.locationName}"
          delete course.locationName
    
  courses.push course

# log(courses.length)
# log(courses)
# log(JSON.stringify(courses))

for course in courses
  $.post "http://localhost:3000/import_mindbody", {course: course}, (response) ->
    log response    
    
# https://clients.mindbodyonline.com/Ajax/ClassInfo/?classid=181
# https://clients.mindbodyonline.com/Ajax/LocationInfo/?locid=3