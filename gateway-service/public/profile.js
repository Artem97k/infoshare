$(document).on( "click", "#profile_create_submit", function() {
  event.preventDefault();
  $.post({ url: "profile/create",
               data: { token: localStorage.getItem('token'),
                       name: $("#name").val(),
                       surname: $("#surname").val(),
                       email: $("#email").val(),
                       bio: $("#bio").val()
                     },
               success: function (data) {
                 if ( data.status === "Ok" ) {
                   $("#main").empty();
                   let page = set_profile_page(data, profile_page);
                   $("#main").prepend(page);
                 } else {
                   $("#info_display").attr("style", "color: red;");
                   $("#info_display").text( data.error );
                 }
               },
               error: function (data) {
                 alert("Server error!");
               }
  });
});

$(document).on( "click", "#profile_edit_submit", function() {
  event.preventDefault();
  $.ajax({ url: "profile/update",
          method: 'PUT',
               data: { token: localStorage.getItem('token'),
                       name: $("#name").val(),
                       surname: $("#surname").val(),
                       email: $("#email").val(),
                       bio: $("#bio").val()
                     },
               success: function (data) {
                 if ( data.status === "Ok" ) {
                   $("#main").empty();
                   let page = set_profile_page(data, profile_page);
                   $("#main").prepend(page);
                 } else {
                   $("#info_display").attr("style", "color: red;");
                   $("#info_display").text( data.error );
                 }
               },
               error: function (data) {
                 alert("Server error!");
               }
  });
});

function set_profile_page(profile_data, page_form) {
  let page = $(page_form);
  page.find("#name").text(profile_data.name);
  page.find("#surname").text(profile_data.surname);
  page.find("#bio").text(profile_data.bio);
  page.find("#email").text(profile_data.email);
  return page
}

function set_profile_edit_page(profile_data, page_form) {
  let page = $(page_form);
  page.find("#name").val(profile_data.name);
  page.find("#surname").val(profile_data.surname);
  page.find("#bio").val(profile_data.bio);
  page.find("#email").val(profile_data.email);
  return page
}

$(document).on( "click", "#profile_edit", function() {
  $("#main").empty();
  $.ajax({url: 'profile',
          data: { login: $("#username").text() },
          success: function (data) {
            if ( data.status === "Ok" ) {
              let page = set_profile_edit_page(data, pe_form);
              $("#main").prepend(page);
            } else {
              $("#info_display").attr("style", "color: red;");
              $("#info_display").text( data.error );
            }
          },
          error: function (data) {
            alert("Server error!");
          }
  });
});
