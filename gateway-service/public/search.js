$(document).on( "click", "#search_submit", function() {
  event.preventDefault();
  $.get({ url: "search",
           data: { query: $("#search_query").val(),
                   type: $("select").val() },
           success: function (data) {

                    },
           error: function (data) {
                    alert("Sorry, service unavailable, come back later!");
                  }
  });
});