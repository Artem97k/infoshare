$(document).on( "click", "#profile_create_submit", function() {
  event.preventDefault();
  $.post({ url: "profile/create",
           data: {  token: localStorage.getItem('token'),
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
  if ( localStorage.getItem('login') === profile_data.login ) {
    page.find(".profile_form").append('<input type="submit" id="profile_edit" class="submit_b" value="Edit profile info" style="width: 100%;">');
  }
  page.append('<p><b>Articles:</b></p>');
  $.post({ url: "article/author",
               data: { user_id: profile_data.user_id },
               success: function (data) {
                 if ( data.status !== "Ok" && data[data.length-1] === undefined ) {
                   $(".profile_page").append("<p>No published articles yet!</p>");
                 } else {
                   if ( data[data.length-1].status === "Ok" ) {
                     data.splice(-1,1);
                     if ( data.length !== 0 ) {
                       let list = set_articles_list(data, articles_list);
                       page.append(list); 
                     } else {
                       $(".profile_page").append("<p>No published articles yet!</p>");
                     }
                   } else {
                     $("#info_display").attr("style", "color: red;");
                     $("#info_display").text( data.error );
                   }
                 }
               },
               error: function (data) {
                 alert("Server error!");
               }
  });
  return page
}

function set_articles_list(articles_data, page_form) {
  let list = $(page_form);
  let row = '<tr><th>Name</th><th>Category</th></tr>';
  list.append(row);
  articles_data.forEach(function(value, index, array) {
    row = '<tr>' +
    `<td class="search_tile article_link" id="${value.id}">` + value.name + '</td>' +
    '<td class="search_tile">' + value.category + '</td>' +
    '</tr>';
    list.append(row);
  });
  return list
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

$(document).on( "click", ".article_link", function() {
  $.get({  url: "article",
           data: { id: $(this).attr("id") },
           success: function (data) {
             if ( data.status === "Ok" ) {
               $("#main").empty();
               let page = set_article_page(data, article_page);
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
