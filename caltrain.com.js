$('head').append(
  '<style type="text/css"> td.active { background-color: #000; color: white;} </style>'
);

// http://stackoverflow.com/questions/5279817/using-jquery-how-to-find-the-index-of-an-element-amongst-its-siblings-of-a-speci
$.fn.getIndex = function(){
  var index = $(this).parent().children().index( $(this) );
  return index;
};

$("#mian_content table tr td").hover(
  function() {
    $(this).closest('tr').find('td').addClass('active');

    var i = $(this).getIndex();
    
    $(this).closest('table').each(function(){
      $(this).find("td:eq(" + i + ")").addClass("active");
    });

  },
  function() {

    $(this).closest('tr').find('td').removeClass('active');

    $('tr').each(function(){
      $(this).find("td:eq(" + i + ")").removeClass("active");
    });

    
  }
);