// app/javascript/search_dropdown.js
$(document).ready(function () {
  $('#search_project').on('input', function () {
    var search_term = $(this).val();

    $.ajax({
      url: '/tasks/search_projects',
      type: 'GET',
      dataType: 'json',
      data: { search_term: search_term },
      success: function (data) {
        var dropdown = $('#project_dropdown');

        // Clear previous options
        dropdown.empty();

        // Append the new options based on the fetched data
        data.forEach(function (project) {
          dropdown.append(
            $('<option>').val(project.id).text(project.name)
          );
        });
      },
      error: function (xhr, status, error) {
        // Your error handling code (if needed)
      }
    });
  });
});
