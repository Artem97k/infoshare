$(document).on( "click", "#search_submit", function() {
  event.preventDefault();
  if ( $("#search_query").val() !== "") {
    switch ($("select").val()) {
      case 'profile':
        $.post({ url: "search",
                 data: { query: $("#search_query").val(),
                         type: $("select").val() },
                 success: function (data) {
                            if ( data[data.length-1].status == "Ok" ) {
                              $("#search_display").remove();
                              $("#info_display").text("");
                              let page = set_profile_search_result_page(data, search_result_page);
                              $("#main").append(page);
                            } else { 
                              $("#search_display").remove();
                              $("#info_display").attr("style", "color: red;");
                              $("#info_display").text("Nothing found!");
                            }
                          },
                 error: function (data) {
                          alert("Server error!");
                        }
        });
    }
  }
});

function set_profile_search_result_page(search_data, page_form) {
  search_data.splice(-1,1);
  let page = $(page_form);
  let row = '<tr><th>Profile link</th><th>Name</th><th>Surname</th></tr>';
  page.append(row);
  search_data.forEach(function(value, index, array) {
    row = '<tr>' +
    '<td class="search_tile profile_link">' + value.login + '</td>' +
    '<td class="search_tile">' + value.name + '</td>' +
    '<td class="search_tile">' + value.surname + '</td>' +
     '</tr>';
    page.append(row);
  });
  return page
}

$(document).on( "click", ".profile_link", function() {
  $.ajax({ url: "profile",
           data: { login: $(this).html() },
           success: function (data) {
                      if ( data.status === "Ok" ) {
                        $("#search_display").remove();
                        $("#search_form").remove();
                        let page = set_profile_page(data, profile_page);
                        if ( localStorage.getItem('login') === data.login) {
                          page.append('<input type="submit" id="profile_edit" class="submit_b" value="Edit profile info">');
                        }
                        $("#main").prepend(page);
                      } else {
                        $("#info_display").attr("style", "color: red;");
                        $("#info_display").text("Error setting profile page!");
                      }
                    },
           error: function (data) {
                    alert("Server error!");
                  }
  });
});
