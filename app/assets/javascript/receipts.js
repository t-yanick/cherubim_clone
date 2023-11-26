console.log("Receipts JavaScript file loaded.");

document.addEventListener('DOMContentLoaded', function() {
  var searchInput = document.getElementById('searchInput');
  var rows = document.querySelectorAll('#receiptsTable tbody tr');

  searchInput.addEventListener('input', function() {
    var searchQuery = searchInput.value.toLowerCase();

    rows.forEach(function(row) {
      var customerName = row.cells[1].textContent.toLowerCase();
      if (customerName.includes(searchQuery)) {
        row.style.display = '';
      } else {
        row.style.display = 'none';
      }
    });
  });
});