$(document).on( "click", "#search_submit", function() {
  event.preventDefault();
  if ( $("#search_query").val() !== "") {
    $.post({ url: "search",
             data: { query: $("#search_query").val(),
                     type: $("select").val() },
             success: function (data) {
                      if ( data[data.length-1].status === "Ok" ) {
                        $("#search_display").remove();
                        $("#info_display").text("");
                        let page = set_search_result_page(data, search_result_page, $("select").val());
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
});

function set_search_result_page(search_data, page_form, type) {
  search_data.splice(-1,1);
  let page = $(page_form);
  let row = '';
  switch(type) {
    case "profile":
      row = '<tr><th>Profile link</th><th>Name</th><th>Surname</th></tr>';
      page.append(row);
      search_data.forEach(function(value, index, array) {
        row = '<tr>' +
        '<td class="search_tile profile_link">' + value.login + '</td>' +
        '<td class="search_tile">' + value.name + '</td>' +
        '<td class="search_tile">' + value.surname + '</td>' +
        '</tr>';
        page.append(row);
      });
      break;
    case "article":
      row = '<tr><th>Author</th><th>Name</th><th>Category</th></tr>';
      page.append(row);
      search_data.forEach(function(value, index, array) {
        row = '<tr>' +
        '<td class="search_tile profile_link">' + value.login + '</td>' +
        `<td class="search_tile article_link" id="${value.id}">` + value.name + '</td>' +
        '<td class="search_tile">' + value.category + '</td>' +
        '</tr>';
        page.append(row);
      });
      break;
    case 'series':
      break;
  }
  return page
}

$(document).on( "click", ".profile_link", function() {
  $.ajax({ url: "profile",
           data: { login: $(this).html() },
           success: function (data) {
                      if ( data.status === "Ok" ) {
                        $("#main").empty();
                        let page = set_profile_page(data, profile_page);
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
