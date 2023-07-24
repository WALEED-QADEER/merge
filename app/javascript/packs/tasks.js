// app/javascript/packs/tasks.js

document.addEventListener('DOMContentLoaded', () => {
    $('.select2').select2({
      theme: 'bootstrap4', // Add this line to use the Bootstrap 4 theme (optional)
      minimumInputLength: 1, // Minimum characters to start showing search results (you can adjust this value)
      ajax: {
        url: '/tasks/search', // Replace this with the appropriate URL for searching projects
        dataType: 'json',
        delay: 250, // Delay in milliseconds before sending the request (you can adjust this value)
        data: function (params) {
          return {
            q: params.term, // Search term typed by the user
            page: params.page
          };
        },
        processResults: function (data, params) {
          return {
            results: data
          };
        },
        cache: true
      }
    });
  });
  