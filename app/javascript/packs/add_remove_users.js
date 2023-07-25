// app/assets/javascripts/add_remove_users.js

document.addEventListener('DOMContentLoaded', function () {
  const addUserBtn = document.querySelector('[data-role="add-user-btn"]');
  addUserBtn.addEventListener('click', function (event) {
    event.preventDefault();
    addNewUserField();
  });

  document.addEventListener('click', function (event) {
    if (event.target.matches('[data-role="remove-user-btn"]')) {
      event.preventDefault();
      removeUserField(event.target);
    }
  });

  function addNewUserField() {
    const membershipFields = document.querySelector('.membership-fields');
    const newUserField = membershipFields.cloneNode(true);

    // Clear the selected user from the newly added field
    const selectInput = newUserField.querySelector('select');
    selectInput.selectedIndex = -1;

    // Set a new unique name for each field to avoid conflicts in params
    const newFieldIndex = Date.now();
    newUserField.querySelectorAll('select, input').forEach((field) => {
      field.name = field.name.replace(/\[\d+\]/, `[${newFieldIndex}]`);
    });

    // Remove the hidden _destroy input from the cloned field
    const destroyInput = newUserField.querySelector('input[name*="_destroy"]');
    if (destroyInput) {
      destroyInput.remove();
    }

    // Add a remove button to the new user field
    const removeUserBtn = document.createElement('button');
    removeUserBtn.textContent = 'Remove';
    removeUserBtn.setAttribute('type', 'button');
    removeUserBtn.setAttribute('data-role', 'remove-user-btn');
    removeUserBtn.classList.add('remove-user-btn');

    newUserField.appendChild(removeUserBtn);
    membershipFields.parentElement.insertBefore(newUserField, addUserBtn);
  }

  function removeUserField(button) {
    const userField = button.closest('.membership-fields');
    const destroyInput = userField.querySelector('input[name*="_destroy"]');

    if (destroyInput) {
      // Mark the field for deletion on form submission
      destroyInput.value = '1';
      userField.style.display = 'none'; // Hide the field instead of removing
    } else {
      // If it's a newly added field, remove it from the DOM
      userField.remove();
    }
  }
});
