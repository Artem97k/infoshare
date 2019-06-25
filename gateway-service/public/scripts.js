const su_form = `
<form id="su_form">
  Login:<br>
  <input type="text" id="login"><br>
  Password:<br>
  <input type="password"id="password"><br>
  Password confirmation:
  <input type="password"id="password2"><br>
  <p style="display: inline; color: red;"id="info_display"></p>
  <input type="submit" id="signup_submit" value="Sign up">
 </form>`;

const si_form = `
<form id="si_form">
  Login:<br>
  <input type="text" id="login"><br>
  Password:<br>
  <input type="password"id="password"><br>
  <p style="display: inline;"id="info_display"></p>
  <input type="submit" id="signin_submit" value="Sign in">
</form>`;

const cr_page = `
<div class="content">
<a class="tile" id="ar_create">Article</a><a class="tile" id="sr_create">Series</a>
</div>`;

const search_form = `
<form id="search_form">
  Search:
  <select>
    <option value="a">Article</option>
    <option value="s">Series</option>
    <option value="p">People</option>
  </select><br>
  <input type="text" id="search_query">
  <input type="submit" id="search_submit" value="Search">
</form>`;

const categories = [ 
  "Category 1", 
  "Category 2", 
  "Category 3", 
  "Category 4", 
  "Category 5", 
  "Category 6",
];

$(document).ready( function() {
  if ( localStorage.getItem('token') ) {
    $("#sign_up").remove();
    $("#sign_in").text("Sign out");
    $("#sign_in").attr("id", "sign_out");
    $(".topnav").append('<a id="create">Create</a>');
    $(".topnav").append('<a id="username">' + localStorage.getItem('login') +'</a>');
  }
});

$(document).on( "click", "#sign_up", function() {
  $("#main").empty();
  $("#main").prepend(su_form);
});

$(document).on( "click", "#sign_in", function() {
  $("#main").empty();
  $("#main").prepend(si_form);
});

$(document).on( "click", "#sign_out", function() {
  localStorage.removeItem('token');
  localStorage.removeItem('login');
  $("#sign_out").remove();
  $("#create").remove();
  $("#username").remove();
  $(".topnav").append('<a id="sign_up">Sign up</a>');
  $(".topnav").append('<a id="sign_in">Sign in</a>');
  $("#main").empty();
});

$(document).on( "click", "#search", function() {
  $("#main").empty();
  $("#main").prepend(search_form);
});

$(document).on( "click", "#categories", function() {
  $("#main").empty();
  let cat_page = '<table style="width:100%; border-spacing:15px;">';
  let l = categories.length / 2;
  var j = 0;
  for (i = 0; i < l; i++) {
    cat_page += '<tr><td>' + categories[j] + '</td>' + '<td>' + categories[j+1] + '</td></tr>';
    j += 2;
  }
  cat_page += '</table>';
  $("#main").prepend(cat_page);
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
      	      	  localStorage.setItem('token', data.token);
      	      	  localStorage.setItem('login', data.login);
      	          alert(localStorage.getItem('token'));
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

$(document).on( "click", "#create", function() {
  $("#main").empty();
  $("#main").prepend(cr_page);
});
