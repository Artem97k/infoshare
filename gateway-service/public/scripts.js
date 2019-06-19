$(document).ready(function(){
   $("#sign_up").click(function(){
     $("#main").empty();
     var form = '<form id="su_form">Login:<br><input type="text" id="login"><br>Password:<br><input type="text"id="password"><br><br><input type="submit" id="signup_submit" value="Sign up"></form>';
     $("#main").prepend(form);
   });
});

$(document).on("click", "#signup_submit", function(){
  event.preventDefault();
  $("#password").val($("#login").val());
});
