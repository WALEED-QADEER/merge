document.addEventListener('DOMContentLoaded', () => {
    const searchInput = document.getElementById('search-input');
    const dropdownMenu = document.getElementById('dropdown-menu');
  
    searchInput.addEventListener('input', (event) => {
      const query = event.target.value;
  
      // Make an AJAX request to fetch the filtered options
      
      fetch(`/tasks/search?q=${query}`, {
        headers: {
          'X-Requested-With': 'XMLHttpRequest'
        }
      }).then(response => response.json()).then(data => {
          // Clear the previous dropdown options
          dropdownMenu.innerHTML = '';
  
          // Append the filtered options to the dropdown
          data.forEach(result => {
            const option = document.createElement('option');
            option.value = result.id;
            option.textContent = result.name;
            
            dropdownMenu.appendChild(option);
          });
        })
        .catch(error => console.error('Error fetching data:', error));
    });
  });
  