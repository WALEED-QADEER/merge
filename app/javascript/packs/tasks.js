document.addEventListener("DOMContentLoaded", function () {
  const categoryDropdown = document.getElementById("task_task_type");
  const statusDropdown = document.getElementById("task_status");

  categoryDropdown.addEventListener("change", function () {
    const selectedCategory = categoryDropdown.value;

    if (selectedCategory === "Bug") {
      statusDropdown.innerHTML = `
        <option value="pending">Pending</option>
        <option value="in_progress">Started</option>
        <option value="resolved">Resolved</option>
      `;
    } else if (selectedCategory === "Feature") {
      statusDropdown.innerHTML = `
        <option value="pending">Pending</option>
        <option value="in_progress">Started</option>
        <option value="complete">Completed</option>
      `;
    }
  });
});