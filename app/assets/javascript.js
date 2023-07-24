$(document).ready(function() {
    // Event handler for the "Add User" link
    $('.add_user_fields').on('click', function(e) {
      e.preventDefault(); // Prevent the default behavior of the link
  
      // Your JavaScript code here
      var userFieldsTemplate = '<%= j(render partial: "user_fields", user_fields: f) %>';
      var userFieldsContainer = $('#user_fields_container');
      var userCount = $(this).data('count');
  
      var time = new Date().getTime();
      var regexp = new RegExp('new_' + 'users', 'g');
      var newFields = userFieldsTemplate.replace(regexp, time);
  
      userFieldsContainer.append(newFields);
      userCount++;
      $(this).data('count', userCount);
    });
  
    // Event handler for the "Remove User" link
    $(document).on('click', '.remove_user_fields', function(e) {
      e.preventDefault(); // Prevent the default behavior of the link
      $(this).closest('.user_fields').remove();
      var userCount = $('.add_user_fields').data('count');
      userCount--;
      $('.add_user_fields').data('count', userCount);
    });
  });