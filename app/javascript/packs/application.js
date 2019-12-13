
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import bulmaQuickview from 'bulma-quickview/src/js'
 
document.addEventListener('turbolinks:load', function() {
  let quickviews = bulmaQuickview.attach()

  const fileInput = document.querySelectorAll('input[type=file].file-input')
  fileInput.forEach(input => {
    input.onchange = () => {
      if (input.files.length > 0) {
        const fileName = input.parentNode.querySelector(".file-name")
        fileName.textContent = input.files[0].name
      }
    }
  })
  
})

if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/service-worker.js', { scope: './' })
  .then(function(reg) {
    console.log('[Companion]', 'Service worker registered!');
    console.log(reg);
  });
}