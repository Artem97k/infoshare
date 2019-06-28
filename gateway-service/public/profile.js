$(document).on( "click", "#profile_edit_submit", function() {
  $.post({ url: "profile/create",
               data: { token: localStorage.getItem('token'),
                       name: $("#name").val(),
                       surname: $("#name").val(),
                       email: $("#name").val(),
                       bio: $("#name").val()
                     },
               success: function (data) {
                 if ( data.status === "Ok" ) {
                   $("#main").empty();
                   $("#main").prepend(profile_page);
                 } else {
                   $("#info_display").attr("style", "color: red;");
                   $("#info_display").text( data.error );
                 }
               },
               error: function (data) {
                 alert("Sorry, service unavailable, come back later!");
               }
  });
});

function set_profile (profile_data) {
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
}
