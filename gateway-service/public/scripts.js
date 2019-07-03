$(document).ready( function() {
  if ( localStorage.getItem('token') ) {
    $("#sign_up").remove();
    $("#sign_in").text("Sign out");
    $("#sign_in").attr("id", "sign_out");
    $(".topnav").append('<a id="create" class="nav">Create</a>');
    $(".topnav").append('<a id="username" class="auth">' + localStorage.getItem('login') +'</a>');
  }
});
