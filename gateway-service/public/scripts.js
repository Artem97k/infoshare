var su_form = '<form id="su_form">Login:<br><input type="text" id="login"><br>Password:<br><input type="password"id="password"><br>Password confirmation:<input type="password"id="password2"><br><p style="display: inline;"id="info_display"></p><input type="submit" id="signup_submit" value="Sign up"></form>';
var si_form = '<form id="si_form">Login:<br><input type="text" id="login"><br>Password:<br><input type="password"id="password"><br><p style="display: inline;"id="info_display"></p><input type="submit" id="signin_submit" value="Sign in"></form>';

$(document).ready(function(){
   $("#sign_up").click(function(){
     $("#main").empty();
     $("#main").prepend(su_form);
   });
});

$(document).ready(function(){
   $("#sign_in").click(function(){
     $("#main").empty();
     $("#main").prepend(si_form);
   });
});

$(document).on( "keyup", "#password2", function() {
  if ( $("#password").val() === $("#password2").val() ) {
   $("#info_display").attr("style", "color: green;");
    $("#info_display").text("Passwords match!");
  } else {
    $("#info_display").attr("style", "color: red;");
    $("#info_display").text("Passwords don't match!");
  }
});

$(document).on("click", "#signup_submit", function(){
  event.preventDefault();
});

$(document).on("click", "#signin_submit", function(){
  event.preventDefault();
});