$(document).on( "click", "#sr_create", function() {
  $("#main").empty();
  $("#main").prepend(sr_create_form);
});

$(document).on( "click", "#series_create_submit", function() {
  event.preventDefault();
  $.post({ url: "series/create",
           data: { token: localStorage.getItem('token'),
                   name: $("#name").val(),
           },
           success: function (data) {
             if ( data.status === "Ok" ) {
               $("#main").empty();
               let page = set_series_page(data, series_page);
               $("#main").prepend(page);
               //let cont = $("#content").html();
               //cont = cont.replace(/(?:\r\n|\r|\n)/g, '<br>');
               //$("#content").text(cont);
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

function set_series_page(series_data, page_form) {
  let page = $(page_form);
  page.find("#name").text(series_data.name);
  if ( localStorage.getItem('login') === series_data.login ) {
    page.append(`<input type="submit" id="${series_data.id}" class="submit_b series_delete" value="Delete series" style="width: 50%;"><br>`);
  }
  page.append('<p><b>Articles:</b></p>');
  if ( localStorage.getItem('login') === series_data.login ) {
    page.append(`<input type="submit" id="${series_data.id}" class="submit_b article_create" value="Add article" style="width: 50%;"><br><br>`);
  }
  $.post({ url: "article/series",
               data: { series_id: series_data.id },
               success: function (data) {
                 if ( data.status !== "Ok" && data[data.length-1] === undefined ) {
                   $(".series_page").append("<p>No published articles yet!</p>");
                 } else {
                   if ( data[data.length-1].status === "Ok" ) {
                     data.splice(-1,1);
                     if ( data.length !== 0 ) {
                       let list = set_articles_list(data, articles_list);
                       page.append(list);
                     } else {
                       $(".series_page").append("<p>No published articles yet!</p>");
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

$(document).on( "click", ".series_delete", function() {
  $.ajax({ url: "series/delete",
           method: "POST",
           data: { token: localStorage.getItem('token'),
                   id: $(this).attr("id"),
           },
           success: function (data) {
             if ( data.article === "Ok" && data.series === "Ok" ) {
               $("#main").empty();
               $("#main").append('<p style="color: green;">Deleted successfully!</p>');
             } else {
               $("#info_display").attr("style", "color: red;");
               $("#info_display").text( data[0].error + ' ' + data[1].error);
             }
           },
           error: function (data) {
             alert("Server error!");
           }
  });
});

$(document).on( "click", ".series_link", function() {
  $.get({  url: "series",
           data: { id: $(this).attr("id") },
           success: function (data) {
             if ( data.status === "Ok" ) {
               $("#main").empty();
               let page = set_series_page(data, series_page);
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

$(document).on( "click", ".article_create", function() {
  $("#main").empty();
  $("#main").prepend(ar_create_form);
  $("#series_id").val($(this).attr("id"));
});
