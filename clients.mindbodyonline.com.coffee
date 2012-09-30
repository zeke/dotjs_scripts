window.log = ->
  console.log.apply console, arguments if window.console
  
class Mindbody
  @baseUrl: "https://clients.mindbodyonline.com/Ajax/"
  
  @trainerUrl: (id) ->
    "#{@baseUrl}QuickStaffBio/?trnid=#{id}"
    
  @classUrl: (id) ->
    "#{@baseUrl}ClassInfo/?classid=#{id}"
      
  @locationUrl: (id) ->
    "#{@baseUrl}LocationInfo/?locid=#{id}"
  
  @scrapeCourses: ->
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
      if location.href.match(/studioid=([-+]\d+)/)?
        course.locationId = location.href.match(/studioid=([-+]\d+)/)[1]

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
    return courses


class Yoga
  @baseUrl: "http://localhost:5000/"
  @createTeacherUrl: "#{@baseUrl}teachers"
  @createSchedulingUrl: "#{@baseUrl}schedulings"

class Teacher
  
  body: ->
    first_name: @first_name
    last_name: @last_name
    avatar_url: @avatar_url
    bio: @bio
    mindbody_id: @mindbody_id
    
  save: ->
    # log @body()
    $.post Yoga.createTeacherUrl, {teacher: @body()}, (response) ->
      # log(response)
      
  @createFromCourseData: (course) ->
    $.get Mindbody.trainerUrl(course.trainerId), (response) ->
      $data = $(response)
      teacher = new Teacher
      teacher.first_name = $data.find('h2').text().split(" ")[0]
      teacher.last_name = $data.find('h2').text().split(" ")[1]
      teacher.avatar_url = $data.find('img').attr('src')
      teacher.bio = $data.find('div.userHTML').html()
      if teacher.avatar_url and teacher.avatar_url.match(/staff\/(\d+)/)?
        teacher.mindbody_id = teacher.avatar_url.match(/staff\/(\d+)/)[1]
      teacher.save()
      
  @scheduleCourse: (course) ->
    $.post Yoga.createSchedulingUrl, {course: course}, (response) ->
      log "nothing yet"

# Do the Do
# -----------------------------------------------------------------------------
Mindbody = Mindbody
Yoga = Yoga
Teacher = Teacher
courses = Mindbody.scrapeCourses()

# for course in courses when course.trainerId?
#   Teacher.createFromCourseData(course)

setTimeout (=>  ), 3000

for course in courses when course.trainerId?
  Teacher.scheduleCourse(course)
  
# for course in courses
#   $.post "http://localhost:3000/import_mindbody", {course: course}, (response) ->
#     log response