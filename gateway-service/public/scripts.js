$(document).ready(function(){
   $("#sign_up").click(function(){
     $("#main").empty();
     var form = '<div>Login:<br><input type="text" id="login"><br>Password:<br><input type="text"id="password"><br><button id="su_button">Sign up</button></div>';
     $("#main").prepend(form);
   });
});

//$(document).ready(function(){
  //$("#su_button").click(function(){
  //   $("#main").empty();
 // });
//});
 // $("#signupForm").submit(function( event ) {
   // event.preventDefault();
    //var url = location.origin + "/signup";
    //var fdata = { login: $("#login").text(), password: $("#password").text() };
   //var posting = $.post(url, fdata);
   // $("#main").empty();
   //posting.done(function(data) {
     // alert( "Data Loaded: " + data );
   // });
//