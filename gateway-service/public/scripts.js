var su_form = '<form id="su_form">Login:<br><input type="text" id="login"><br>Password:<br><input type="password"id="password"><br>Password confirmation:<input type="password"id="password2"><br><p style="display: inline; color: red;"id="info_display"></p><input type="submit" id="signup_submit" value="Sign up"></form>';
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

$(document).ready(function(){
   $("#sign_out").click(function(){
     sessionStorage.removeItem('token');
     $("#sign_out").remove();
     $("#create").remove();
     $(".topnav").append('<a id="sign_up">Sign up</a>');
     $(".topnav").append('<a id="sign_in">Sign in</a>');
     $("#main").empty();
   });
});

$(document).on( "click", "#sign_out", function() {
  sessionStorage.removeItem('token');
  $("#sign_out").remove();
  $("#create").remove();
  $("#username").remove();
  $(".topnav").append('<a id="sign_up">Sign up</a>');
  $(".topnav").append('<a id="sign_in">Sign in</a>');
  $("#main").empty();
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

$(document).on( "keyup", "#password", function() {
  if ( $("#su_form").length ) {
    if ( $("#password").val() === $("#password2").val() ) {
     $("#info_display").attr("style", "color: green;");
      $("#info_display").text("Passwords match!");
    } else {
      $("#info_display").attr("style", "color: red;");
      $("#info_display").text("Passwords don't match!");
    }
  }
});

$(document).on("click", "#signup_submit", function(){
  event.preventDefault();
  if ( $("#password").val() === $("#password2").val() ) {
    if ( $("#login").val() !== "" ) {
      $.post({ url: "signup/",
      	       data: { login: $("#login").val(), password: $("#password").val()  },
      	       success: function (data) {
      	         alert(JSON.stringify(data));
      	       },
      	       error: function (data) {
      	         alert("Sorry, service unavailable, come back later!");
      	       }
       });
    } else {
      $("#info_display").attr("style", "color: red;");
      $("#info_display").text("Enter login!");
    }
  } else {
  	$("#info_display").attr("style", "color: #2529f9;");
  	setTimeout(function() { $("#info_display").attr("style", "color: red;"); }, 150);
  	setTimeout(function() { $("#info_display").attr("style", "color: #2529f9;"); }, 150);
  	setTimeout(function() { $("#info_display").attr("style", "color: red;"); }, 150);
  }
});

$(document).on("click", "#signin_submit", function(){
  event.preventDefault();
  if ( $("#login").val() !== "" && $("#password").val() !== "" ) {
      $.post({ url: "login/",
      	      data: { login: $("#login").val(), password: $("#password").val()  },
      	      success: function (data) {
      	      	if ( data.status === "Ok" ) {
      	      	  $("#sign_up").remove();
      	      	  $("#sign_in").text("Sign out");
      	      	  $("#sign_in").attr("id", "sign_out");
      	      	  $(".topnav").append('<a id="create">Create</a>');
      	      	  $(".topnav").append('<a id="username">' + data.login +'</a>');
      	      	  sessionStorage.setItem('token', data.token);
      	          alert(sessionStorage.getItem('token'));
      	        }
      	      },
      	      error: function (data) {
      	        alert("Sorry, service unavailable, come back later!");
      	      }
       });
    } else {
      $("#info_display").attr("style", "color: red;");
      $("#info_display").text("Enter login and/or password!");
    }
    $("#main").empty();
});

