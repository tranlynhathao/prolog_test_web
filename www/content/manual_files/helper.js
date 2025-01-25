const themeToggleButton = document.getElementById("theme-toggle");
const body = document.body;

themeToggleButton.addEventListener("click", function () {
  body.classList.toggle("dark-mode");

  if (body.classList.contains("dark-mode")) {
    themeToggleButton.innerHTML = '<i class="fas fa-sun"></i>';
  } else {
    themeToggleButton.innerHTML = '<i class="fas fa-moon"></i>';
  }
});
