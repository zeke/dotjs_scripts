
// Turn all CloudApp links into images, except on the CloudApp site itself
if (document.domain.match('cl.ly') == null) {
  $("a[href*='cl.ly']").each(function(){
    var id = $(this).attr('href').split("/").reverse()[0];
    $(this).html("<img src='http://cl.ly/image/" + id  + "/content#.png'>");
  });
}