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
                 if ( data.status === "Ok" ) {
                  $("#info_display").attr("style", "color: green;");
                  $("#info_display").text( "Successfull registration!" );
                 } else {
                  $("#info_display").attr("style", "color: red;");
                  $("#info_display").text( data.error );
                 }
      	       },
      	       error: function (data) {
      	         alert("Server error!");
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
  if ( $("#login").val() !== "" || $("#password").val() !== "" ) {
      $.post({ url: "login/",
      	      data: { login: $("#login").val(), password: $("#password").val()  },
      	      success: function (data) {
      	      	if ( data.status === "Ok" ) {
      	      	  $("#sign_up").remove();
      	      	  $("#sign_in").text("Sign out");
      	      	  $("#sign_in").attr("id", "sign_out");
                  $("#sign_in").attr("class", "auth");
      	      	  $(".topnav").append('<a id="create" class="nav">Create</a>');
      	      	  $(".topnav").append('<a id="username" class="auth">' + data.login +'</a>');
                  $("#username").attr("class", "auth");
      	      	  localStorage.setItem('token', data.token);
      	      	  localStorage.setItem('login', data.login);
                  localStorage.setItem('user_id', data.user_id);
                  $("#main").empty();
      	        } else {
                  $("#info_display").attr("style", "color: red;");
                  $("#info_display").text( data.error );
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
});
