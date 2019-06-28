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
  $(".topnav").append('<a id="sign_up" class="auth">Sign up</a>');
  $(".topnav").append('<a id="sign_in" class="auth">Sign in</a>');
  $("#main").empty();
});

$(document).on( "click", "#username", function() {
  $("#main").empty();
  $.get({ url: "profile/",
               data: { login: $("#username").val() },
               success: function (data) {
                 if ( data.status === "Ok" ) {
                   $("#main").prepend(profile_page);
                 } else {
                   let form = $(pe_form);
                   form.find("#info_display").text("Create profile to publish articles!");
                   form.find("#profile_edit_submit").attr("value","Create");
                   $("#main").prepend(form);
                 }
               },
               error: function (data) {
                 alert("Sorry, service unavailable, come back later!");
               }
  });
});
