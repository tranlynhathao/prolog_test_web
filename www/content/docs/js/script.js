// Get the toggle button and the navbar
const toggleButton = document.getElementById("toggleButton");
const navbar = document.getElementById("navbar");

// Add event listener to toggle the navbar visibility
toggleButton.addEventListener("click", () => {
  navbar.classList.toggle("hidden"); // Toggle the 'hidden' class
});
