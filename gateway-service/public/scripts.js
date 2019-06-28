$(document).ready( function() {
  if ( localStorage.getItem('token') ) {
    $("#sign_up").remove();
    $("#sign_in").text("Sign out");
    $("#sign_in").attr("id", "sign_out");
    $(".topnav").append('<a id="create" class="nav">Create</a>');
    $(".topnav").append('<a id="username" class="auth">' + localStorage.getItem('login') +'</a>');
  }
});

$(document).on( "click", "#search", function() {
  $("#main").empty();
  $("#main").prepend(search_form);
});

$(document).on( "click", "#categories", function() {
  $("#main").empty();
  let cat_page = '<table style="width:100%; border-spacing:14px;">';
  let l = categories.length / 2;
  var j = 0;
  for (i = 0; i < l; i++) {
    cat_page += '<tr><td>' + categories[j] + '</td>' + '<td>' + categories[j+1] + '</td></tr>';
    j += 2;
  }
  cat_page += '</table>';
  $("#main").prepend(cat_page);
});

$(document).on( "click", "#create", function() {
  $("#main").empty();
  $("#main").prepend(cr_page);
});
