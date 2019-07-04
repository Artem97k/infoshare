$(document).on( "click", ".cat", function() {
  $.post({  url: "article/category",
           data: { category: $(this).attr("id") },
           success: function (data) {
             if ( data.status !== "Ok" && data[data.length-1] === undefined ) {
               $("#info_display").attr("style", "color: red;");
               $("#info_display").text(data.error);
             } else {
               if ( data[data.length-1].status === "Ok" ) {
                 $("#main").empty();
                 let page = set_category_page(data, category_page);
                 $("#main").prepend(page);
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
});

function set_category_page(category_data, page_form) {
  category_data.splice(-1,1);
  let page = $(page_form);
  page.prepend(`<tr><th></th><th style="font-size: 17px;">Articles about ${category_data[0].category}</th></tr>`);
  let row = '<tr><th>Author</th><th>Name</th><th>Category</th></tr>';
  page.append(row);
  category_data.forEach(function(value, index, array) {
    row = '<tr>' +
    '<td class="search_tile profile_link">' + value.login + '</td>' +
    `<td class="search_tile article_link" id="${value.id}">` + value.name + '</td>' +
    '<td class="search_tile">' + value.category + '</td>' +
    '</tr>';
    page.append(row);
  });
  return page
}
