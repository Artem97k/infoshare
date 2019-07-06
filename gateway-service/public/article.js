$(document).on( "click", "#ar_create", function() {
  $("#main").empty();
  $("#main").prepend(ar_create_form);
});

$(document).on( "click", "#article_create_submit", function() {
  event.preventDefault();
  $.post({ url: "article/create",
           data: { token: localStorage.getItem('token'),
                   name: $("#name").val(),
                   content: $("#content").val(),
                   series_id: $("#series_id").val(),
                   category: $("select").val()
           },
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

function set_article_page(article_data, page_form) {
  let page = $(page_form);
  page.find("#name").text(article_data.name);
  page.find("#content").text(article_data.content);
  page.find("#category").text(article_data.category);
  if ( localStorage.getItem('login') === article_data.login ) {
    page.append(`<input type="submit" id="${article_data.id}" class="submit_b article_delete" value="Delete article" style="width: 50%;">`);
  }
  return page
}

$(document).on( "click", ".article_delete", function() {
  $.ajax({ url: "article/delete",
           method: "DELETE",
           data: { token: localStorage.getItem('token'),
                   id: $(this).attr("id") 
           },
           success: function (data) {
             if ( data.status === "Ok" ) {
               $("#main").empty();
               $("#main").append('<p style="color: green;">Deleted successfully!</p>');
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
